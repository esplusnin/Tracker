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
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Даже если это не литры воды и йога"
        
        return label
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
        pageControl.currentPageIndicatorTintColor = .blackDay
        pageControl.pageIndicatorTintColor = .blackDay.withAlphaComponent(0.3)
        
        return pageControl
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Вот это технологии!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textColor = .whiteDay
        button.backgroundColor = .blackDay
        
        return button
    }()
}
