//
//  MainTabBarViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: DownloadsViewController())
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc4.tabBarItem.image = UIImage(systemName: "person")
    
        
        vc1.title = "Home"
        vc2.title = "Top Search"
        vc3.title = "Downloads"
        vc4.title = "Profile"
        
        
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)

    }


}

