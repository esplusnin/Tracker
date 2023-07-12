//
//  FirstOnboardingViewController.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import UIKit
import SnapKit

final class FirstOnboardingViewController: UIViewController {
    
    private let firstOnboardingView = FirstOnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        setTarget()
    }
    
    private func setTarget() {
        firstOnboardingView.button.addTarget(self, action: #selector(switchToTabBarController), for: .touchUpInside)
    }
    
    @objc private func switchToTabBarController() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .overFullScreen
        FirstEntryRevisionService().isFirstEntry = false
        
        dismiss(animated: true)
        present(tabBarController, animated: true)
    }
}

// MARK: - Settings views
extension FirstOnboardingViewController {
    private func setViews() {
        view.addSubview(firstOnboardingView.backgroundImageView)
        view.addSubview(firstOnboardingView.introduceLabel)
        view.addSubview(firstOnboardingView.pageControl)
        view.addSubview(firstOnboardingView.button)
    }
}

// MARK: - Settings constraints
extension FirstOnboardingViewController {
    private func setConstraints() {
        firstOnboardingView.backgroundImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        firstOnboardingView.button.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(85)
        }
        
        firstOnboardingView.pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(firstOnboardingView.button.snp.top).inset(-25)
            make.centerX.equalToSuperview()
        }
        
        firstOnboardingView.introduceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(firstOnboardingView.pageControl.snp.top).inset(-130)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
