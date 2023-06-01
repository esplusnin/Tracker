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
        label.text = "Создание трекера"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var habitCreateButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitle("Привычка", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor.whiteDay, for: .normal)
        
        return button
    }()
    
    lazy var unregularEventCreateButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitle("Нерегулярные событие", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.whiteDay, for: .normal)
        
        return button
    }()
}
