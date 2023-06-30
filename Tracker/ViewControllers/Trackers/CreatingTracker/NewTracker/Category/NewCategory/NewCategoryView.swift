//
//  NewCategoryView.swift
//  Tracker
//
//  Created by Евгений on 24.05.2023.
//

import UIKit

final class NewCategoryView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        label.text = LocalizableConstants.NewCategory.title
        
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .backgroundDay
        textField.placeholder = LocalizableConstants.NewCategory.textFieldPlaceholder
        
        return textField
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.setTitle(LocalizableConstants.NewCategory.readyButton, for: .normal)
        button.setTitleColor(.whiteDay, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .gray
        
        return button
    }()
}
