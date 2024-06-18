//
//  MainTabBarController.swift
//  Minima
//
//  Created by Jaka on 2024-06-18.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = Color.orange
        tabBar.unselectedItemTintColor = .gray

        let mainPage = MainPageViewController()
        let nav1 = UINavigationController(rootViewController: mainPage)
        nav1.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let settingPage = SettingViewController()
        let nav2 = UINavigationController(rootViewController: settingPage)
        nav2.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
