//
//  NavigationBarController.swift
//  Tracker
//
//  Created by Евгений on 21.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        tabBar.standardAppearance = appearance
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.systemGray.cgColor
        
        let trackersViewController = TrackersViewController()
        
        let trackersViewControllerNavigation = UINavigationController(rootViewController: trackersViewController)
        let statisticViewControllerNavigation = UINavigationController(rootViewController: StatisticViewController())
        
        
        trackersViewControllerNavigation.tabBarItem = UITabBarItem(title: LocalizableConstants.TabBar.trackers,
                                                                   image: Resources.Images.trackersTabBar,
                                                                   selectedImage: nil)
        statisticViewControllerNavigation.tabBarItem = UITabBarItem(title: LocalizableConstants.TabBar.statistics,
                                                                    image: Resources.Images.statisticTabBar,
                                                                    selectedImage: nil)
        
        self.viewControllers = [trackersViewControllerNavigation, statisticViewControllerNavigation]
    }
}
