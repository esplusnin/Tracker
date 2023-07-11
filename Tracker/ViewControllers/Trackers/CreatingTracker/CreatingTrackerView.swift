//
//  CreatingTrackerView.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class CreatingTrackerView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.CreatingTracker.title
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var habitCreateButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitle(L10n.CreatingTracker.habit, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor.whiteDay, for: .normal)
        
        return button
    }()
    
    lazy var unregularEventCreateButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitle(L10n.CreatingTracker.unregularEvent, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.whiteDay, for: .normal)
        
        return button
    }()
}
