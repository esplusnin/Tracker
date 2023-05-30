//
//  NewHabitView.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class NewTrackerView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .backgroundDay
        textField.placeholder = "Введите название трекера"
        textField.textColor = .blackDay
        textField.font = .systemFont(ofSize: 17)
        
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
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
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .gray
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    lazy var warningTextFieldLimitationLabel: UILabel = {
        let label = UILabel()
        label.text = "Ограничение 38 символов"
        label.textColor = .red
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
}
