//
//  TabBarController.swift
//  CoffeeIT
//
//  Created by Wouter Willebrands on 16/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let tabBarTitles: [String] = ["Discover", "Lifestyle", "Profile"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar() {
        let discoverController = UINavigationController(rootViewController: DiscoverViewController())
        let discoverImage = UIImage(named: .discover)?.withRenderingMode(.alwaysTemplate)
        discoverController.tabBarItem.image = discoverImage
        discoverController.tabBarItem.title = tabBarTitles[0]

        let lifestyleController = UINavigationController(rootViewController: LifeStyleViewController())
        let lifestyleImage = UIImage(named: .tree)?.withRenderingMode(.alwaysTemplate)
        lifestyleController.tabBarItem.image = lifestyleImage
        lifestyleController.tabBarItem.title = tabBarTitles[1]

        let profileController = UINavigationController(rootViewController: ProfileViewController())
        let profileImage = UIImage(named: .profile)?.withRenderingMode(.alwaysTemplate)
        profileController.tabBarItem.image = profileImage
        profileController.tabBarItem.title = tabBarTitles[2]

        viewControllers = [discoverController, lifestyleController, profileController]
    }
}
