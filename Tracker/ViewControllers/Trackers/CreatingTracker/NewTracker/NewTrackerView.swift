//
//  NewHabitView.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class NewTrackerView {
    
    lazy var scrollView = UIScrollView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        
        if NSLocale.current.languageCode == "ar" {
                textField.textAlignment = .right
        } else {
            textField.textAlignment = .left
        }
        
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .backgroundDay
        textField.placeholder = LocalizableConstants.NewTracker.textFieldPlaceholder
        textField.textColor = .blackDay
        textField.font = .systemFont(ofSize: 17)
        
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 17
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.allowsMultipleSelection = true
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = .white
        button.setTitle(LocalizableConstants.NewTracker.buttonCancel, for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .gray
        button.setTitle(LocalizableConstants.NewTracker.buttonCreate, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    lazy var warningTextFieldLimitationLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableConstants.NewTracker.warning
        label.textColor = .red
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
}
