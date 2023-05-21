//
//  ViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 20.05.2023.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let v1 = UINavigationController(rootViewController: HomeViewController())
        let v2 = UINavigationController(rootViewController: SearchViewController())
        let v3 = UINavigationController(rootViewController: NotificationViewController())
        let v4 = UINavigationController(rootViewController: MessageViewController())

        v1.tabBarItem.image = UIImage(systemName: "house")
        v1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        v2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        v3.tabBarItem.image = UIImage(systemName: "bell")
        v3.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        v4.tabBarItem.image = UIImage(systemName: "envelope")
        v4.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        setViewControllers([v1,v2,v3,v4], animated: true)
    }


}

