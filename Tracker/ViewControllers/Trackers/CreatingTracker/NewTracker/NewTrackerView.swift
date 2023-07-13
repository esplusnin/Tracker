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
        textField.textAlignment = NSLocale.current.languageCode == "ar" ? .right : .left
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .backgroundDay
        textField.placeholder = L10n.NewTracker.TextField.placeholder
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
        button.backgroundColor = .whiteDay
        button.setTitle(L10n.NewTracker.Buttons.cancel, for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .gray
        button.setTitle(L10n.NewTracker.Buttons.create, for: .normal)
        button.setTitleColor(.whiteDay, for: .normal)
        
        return button
    }()
    
    lazy var warningTextFieldLimitationLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.NewTracker.warning
        label.textColor = .red
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    lazy var countOfCompleteDaysLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        
        return label
    }()
    
    lazy var leftStepperButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 6
        button.backgroundColor = .blackDay
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.whiteDay, for: .normal)
        
        return button
    }()
    
    lazy var rightStepperButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 6
        button.backgroundColor = .blackDay
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.whiteDay, for: .normal)
        
        return button
    }()
}
