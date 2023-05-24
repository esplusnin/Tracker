//
//  CreatingTrackerViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class CreatingTrackerViewController: UIViewController {
    private let creatingTrackerView = CreatingTrackerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        setTargets()
    }
    
    private func setTargets() {
        creatingTrackerView.habitCreateButton.addTarget(self, action: #selector(switchToNewHabitVC), for: .touchUpInside)
        creatingTrackerView.unregularEventCreateButton.addTarget(self, action: #selector(switchToNewUnregularVC), for: .touchUpInside)
    }
    
    @objc func switchToNewHabitVC() {
        let viewController = NewTrackerViewController()
        viewController.tracker = .habit
        
        present(viewController, animated: true)
    }
    
    @objc func switchToNewUnregularVC() {
        let viewController = NewTrackerViewController()
        viewController.tracker = .unregularEvent
        
        present(viewController, animated: true)
    }

    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(creatingTrackerView.titleLabel)
        view.addSubview(creatingTrackerView.habitCreateButton)
        view.addSubview(creatingTrackerView.unregularEventCreateButton)
    }
    
    private func setConstraints() {
        creatingTrackerView.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
        }
        
        creatingTrackerView.habitCreateButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(creatingTrackerView.titleLabel.snp.bottom).inset(-295)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        creatingTrackerView.unregularEventCreateButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(creatingTrackerView.habitCreateButton.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
