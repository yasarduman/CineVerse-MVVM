//
//  ProfileViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit
import FirebaseAuth
import SDWebImage

class ProfileViewController : UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    // MARK: - Properties
    lazy var vm = ProfileVM()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
       return table
    }()
    
    private lazy var models = [Section]()
    
    // MARK: - Header View
    private var headerView: ProfileUIView?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHeaderView()
        tableView.tableHeaderView = headerView
 
    }
    
    // MARK: - Configure HeaderView
    private func configureHeaderView() {
        headerView = ProfileUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 180))
        
     
        //image tıklana bilir hale getirdik
        headerView?.userImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooeseImage))
        headerView?.userImage.addGestureRecognizer(gestureRecognizer)
        
        vm.fetchUserPhoto { url in
            guard let url = URL(string: url) else {
                return
            }
            self.headerView?.userImage.sd_setImage(with: url, completed: nil)
      
        }
        
        vm.fetchUserName { userName in
            self.headerView?.userName.text = userName
            
            //Flitered userName
            let nameSurname = userName.components(separatedBy: " ")
            if nameSurname.count >= 2 {
                let userNamex = nameSurname[0]
                self.headerView?.userMesage.text = "Tekrardan Hoşgeldin \(userNamex) 🎉"
            } else {
                print("Tekrardan Hoşgeldin 🎉")
            }
        }
    }
     
    // MARK: - Configure UI
    private func configureUI(){
        setupTableView()
        configureTableViewCell()
    }
    
    private func setupTableView() {
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.frame
            tableView.backgroundColor = .systemBackground
            tableView.separatorStyle = .none
        }
    
    let isDarkModeOn = UserDefaults.standard.bool(forKey: "DarkMode")
      
    private func configureTableViewCell() {
        models.append(Section(title: "", options: [
            .switchCell(model: SettingsSwitchOption(title: "Dark Mode", icon: UIImage(systemName: "moon.stars"), iconBackgrondColor: MovieColor.goldColor, handler: {
                
            }, isOn: isDarkModeOn)),
            
            .staticCell(model: SettingsOption(title: "Change Password", icon: UIImage(systemName: "exclamationmark.lock.fill"), iconBackgrondColor: MovieColor.goldColor, handler: {
                let vc = ChangePasswordVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })),
            .staticCell(model: SettingsOption(title: "Help and Support", icon: UIImage(systemName: "questionmark.circle"), iconBackgrondColor: MovieColor.goldColor, handler: {
                let vc = HelpAndSupportVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })),
            .staticCell(model: SettingsOption(title: "Log out", icon: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), iconBackgrondColor: MovieColor.goldColor, handler: {
                do {
                    try Auth.auth().signOut()
                    let loginVC = LoginVC()
                    let nav = UINavigationController(rootViewController: loginVC)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true, completion: nil)
                    
                } catch  {
                    print(error.localizedDescription )
                }
            })),
        ]))
    }
    
    // MARK: - Action
    //image Func
    @objc func chooeseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        headerView?.userImage.image = info[.originalImage] as? UIImage
        vm.uploadUserPhoto(imageData: (headerView?.userImage.image!)!)
        self.dismiss(animated: true)
}
}

// MARK: - Table View Data Source
extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        case .switchCell(let model):
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
}

// MARK: - Table View Delegate
extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            model.handler()
            
        case .switchCell(let model):
            model.handler()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired row height
        return 60.0
    }
}
