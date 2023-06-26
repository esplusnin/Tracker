//
//  SecondOnboardingViewController.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import UIKit
import SnapKit

final class SecondOnboardingViewController: UIViewController {
    
    private let secondOnboardingView = SecondOnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        setTarget()
    }
    
    private func setTarget() {
        secondOnboardingView.button.addTarget(self, action: #selector(switchToTabBarController), for: .touchUpInside)
    }
    
    @objc private func switchToTabBarController() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .overFullScreen
        FirstEntryRevisionService().isFirstEntry = false
        
        dismiss(animated: true)
        present(tabBarController, animated: true)
    }
}

// Setup views
extension SecondOnboardingViewController {
    private func setViews() {
        view.addSubview(secondOnboardingView.backgroundImageView)
        view.addSubview(secondOnboardingView.introduceLabel)
        view.addSubview(secondOnboardingView.pageControl)
        view.addSubview(secondOnboardingView.button)
    }
}

extension SecondOnboardingViewController {
    private func setConstraints() {
        secondOnboardingView.backgroundImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        secondOnboardingView.button.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(85)
        }
        
        secondOnboardingView.pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(secondOnboardingView.button.snp.top).inset(-25)
            make.centerX.equalToSuperview()
        }
        
        secondOnboardingView.introduceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(secondOnboardingView.pageControl.snp.top).inset(-130)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
