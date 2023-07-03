//
//  FilterCell.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import UIKit
import SnapKit

final class FilterCell: UITableViewCell {
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .blackDay
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(cellLabel)
        
        cellLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        backgroundColor = UIColor.backgroundDay
    }
}
