//
//  SecondOnboardingView.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import UIKit

final class SecondOnboardingView {
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.secondBackgroundImage
        
        return imageView
    }()
    
    lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = L10n.Onboarding.SecondScreen.title
        
        return label
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .black.withAlphaComponent(0.3)
        
        return pageControl
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle(L10n.Onboarding.continueButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .black
        
        return button
    }()
}
