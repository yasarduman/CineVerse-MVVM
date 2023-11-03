//
//  ProfileViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit

class ProfileViewController : UIViewController {
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
       return table
    }()
    
    private lazy var models = [Section]()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
            tableView.frame = view.bounds
            tableView.backgroundColor = .systemBackground
            tableView.separatorStyle = .none
        }
    
    private func configureTableViewCell() {
        models.append(Section(title: "", options: [
            .switchCell(model: SettingsSwitchOption(title: "Dark Mode", icon: UIImage(systemName: "moon.stars"), iconBackgrondColor: MovieColor.goldColor, handler: {
                // Handle switch optio
            }, isOn: true)),
            
            .staticCell(model: SettingsOption(title: "Change Password", icon: UIImage(systemName: "exclamationmark.lock.fill"), iconBackgrondColor: MovieColor.goldColor, handler: {
                
            })),
            .staticCell(model: SettingsOption(title: "Help and Support", icon: UIImage(systemName: "questionmark.circle"), iconBackgrondColor: MovieColor.goldColor, handler: {
              
            })),
            .staticCell(model: SettingsOption(title: "Log out", icon: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), iconBackgrondColor: MovieColor.goldColor, handler: {
                
            })),
        ]))
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

#Preview{
    ProfileViewController()
}
