//
//  EditingCategoryView.swift
//  Tracker
//
//  Created by Евгений on 04.07.2023.
//

import UIKit

final class EditingCategoryView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        label.text = L10n.EditingCategory.title
        
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        
        if NSLocale.current.languageCode == "ar" {
                textField.textAlignment = .right
        } else {
            textField.textAlignment = .left
        }
        
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .backgroundDay
        
        return textField
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.setTitle(L10n.EditingCategory.completeButton, for: .normal)
        button.setTitleColor(.whiteDay, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .backgroundDay
        
        return button
    }()
}
