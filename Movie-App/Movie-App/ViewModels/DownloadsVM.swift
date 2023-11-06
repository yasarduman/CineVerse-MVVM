//
//  DownloadsVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import Foundation
import FirebaseFirestore

import FirebaseAuth
class DownloadsVM {
    let currentUserID = Auth.auth().currentUser!.uid
    
    func fetchFavorites(completion: @escaping([Movie]) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                let movies = documents.compactMap({try? $0.data(as: Movie.self)})
                completion(movies)
            }
    }
    
    
    
    func removeFromFavorites(movies: Movie) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(String(movies.id))
            .delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
}
