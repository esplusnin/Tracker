//
//  OnboardingPageViewController.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController {
    let controller = [FirstOnboardingViewController(), SecondOnboardingViewController()]
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        dataSource = self
        
        if let first = controller.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controller.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        return controller[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controller.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = index + 1
        guard nextIndex < controller.count else {
            return nil
        }
        
        return controller[nextIndex]
    }
}
