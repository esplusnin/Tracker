//
//  NewHabitView.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class NewHabitView {
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Новая привычка"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.blackDay
        
        return label
    }()
}
