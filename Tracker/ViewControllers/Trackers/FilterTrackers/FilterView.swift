//
//  FilterView.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import UIKit

final class FilterView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Filter.title
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 17
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        return tableView
    }()
}
