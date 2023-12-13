//
//  TabViewController.swift
//  cryptotracker
//
//  Created by Josiel Perez on 10/16/23.
//

import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        let tab1 = TrackerViewController()
        tab1.title = "Home"

        let tab2 = SettingsViewController()
        tab2.title = "Settings"
        
        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)

        nav1.tabBarItem = UITabBarItem(title: "Cryptos", image: UIImage(systemName: "dollarsign"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)

        setViewControllers([
            nav1,
            nav2,
        ], animated: true)
        

    }
}
