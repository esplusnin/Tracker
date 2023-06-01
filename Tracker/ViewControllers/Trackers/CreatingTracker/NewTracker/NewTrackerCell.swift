//
//  NewHabitCell.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class NewTrackerCell: UITableViewCell {
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var selectedCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.backgroundDay
        self.accessoryType = .disclosureIndicator
    }
    
    func setViewsWithoutCategory() {
        contentView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    func setViewsWithCategory(_ category: String) {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(selectedCategoryLabel)
        
        selectedCategoryLabel.text = category
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(16)
        }
        
        selectedCategoryLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalTo(categoryLabel.snp.bottom).inset(-2)
            make.leading.equalTo(categoryLabel)
        }
    }
}
