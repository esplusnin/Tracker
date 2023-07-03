//
//  ScheduleView.swift
//  Tracker
//
//  Created by Евгений on 23.05.2023.
//

import UIKit

final class ScheduleView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableConstants.ScheduleVC.title
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.blackDay
        
        return label
    }()
    
    lazy var scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 16
        
        return tableView
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.setTitle(LocalizableConstants.ScheduleVC.ready, for: .normal)
        button.setTitleColor(UIColor.whiteDay, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = UIColor.blackDay
        
        return button
    }()
}
