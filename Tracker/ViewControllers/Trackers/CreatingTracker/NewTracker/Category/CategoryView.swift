//
//  CategoryView.swift
//  Tracker
//
//  Created by Евгений on 24.05.2023.
//

import UIKit

final class CategoryView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var emptyCategoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.trackersIsEmpty
        
        return imageView
    }()
    
    lazy var emptyCategoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Привычки и события можно\nобъединить по смыслу"
        label.textAlignment = .center
        label.textColor = .blackDay
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 16
        
        return tableView
    }()
    
    lazy var createCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackDay
        button.setTitle("Добавить категорию", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.whiteDay, for: .normal)
        
        return button
    }()
}
