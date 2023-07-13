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

        let separator = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.5))
        separator.backgroundColor = .blackNight
            tabBar.shadowImage = UIImage()
            tabBar.addSubview(separator)
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        tabBar.standardAppearance = appearance
        tabBar.backgroundColor = .whiteDay

        let trackersViewController = TrackersViewController()
        let statisticsViewController = StatisticViewController()
                
        let trackersViewControllerNavigation = UINavigationController(rootViewController: trackersViewController)
        let statisticViewControllerNavigation = UINavigationController(rootViewController: statisticsViewController)
        
        
        trackersViewControllerNavigation.tabBarItem = UITabBarItem(title: L10n.TabBar.trackers,
                                                                   image: Resources.Images.trackersTabBar,
                                                                   selectedImage: nil)
        statisticViewControllerNavigation.tabBarItem = UITabBarItem(title: L10n.TabBar.statistics,
                                                                    image: Resources.Images.statisticTabBar,
                                                                    selectedImage: nil)
        
        self.viewControllers = [trackersViewControllerNavigation, statisticViewControllerNavigation]
    }
}
