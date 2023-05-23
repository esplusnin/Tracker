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
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.backgroundColor = UIColor.backgroundDay
        textField.placeholder = "Введите название трекера"
        textField.textColor = UIColor.gray
        textField.font = UIFont.systemFont(ofSize: 17)
        
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 17
        tableView.separatorStyle = .singleLine
        
        return tableView
    }()
    
    lazy var colorCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = .white
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        
        return button
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.gray
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
}
