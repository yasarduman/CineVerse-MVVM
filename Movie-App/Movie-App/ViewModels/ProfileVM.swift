//
//  ProfileVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

// MARK: - Section Data Structure
struct Section {
    let title: String
    let options: [SettingsOptionType]
}

// MARK: - Settings Option Type Enumeration
enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

// MARK: - Switch Option Data Structure
struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgrondColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

// MARK: - Settings Option Data Structure
struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgrondColor: UIColor
    let handler: (() -> Void)
}


protocol ProfileVMInterface: AnyObject {
    func viewDidLoad()
}

// MARK: - ViewModel
final class ProfileVM {
    private var view: ProfileVCInterface?
    private let currentUserID = Auth.auth().currentUser!.uid
    lazy var models = [Section]()
    
    init(view: ProfileVCInterface? = nil) {
        self.view = view
    }
    
    func fetchUserName(completion: @escaping (String) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let snapshot = snapshot {
                    if let data = snapshot.data() {
                        let userName = data["userName"] as! String
                        completion(userName)
                    }
                }
            }
    }
    
    func uploadUserPhoto(imageData: UIImage) {
        let storageRefernce = Storage.storage().reference()
        
        //turn of image into data
        let imageData = imageData.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else{
            return
        }
        
        let fileRef = storageRefernce.child("Media/\(currentUserID).jpg")
        
        fileRef.putData(imageData!, metadata: nil)
    }
    
    func fetchUserPhoto(completion: @escaping (String) -> Void) {
        let storageRef = Storage.storage().reference()
        
        let fileRef = storageRef.child("Media/\(currentUserID).jpg")
        fileRef.downloadURL { url, error in
            if error == nil {
                let imageUrl = url?.absoluteString
                completion(imageUrl!)
            }
        }
    }
}

extension ProfileVM: ProfileVMInterface {
    func viewDidLoad() {
        view?.configureViewDidLoad()
    }
}
