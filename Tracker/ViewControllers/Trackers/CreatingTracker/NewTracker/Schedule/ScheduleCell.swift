//
//  ScheduleCell.swift
//  Tracker
//
//  Created by Евгений on 23.05.2023.
//

import UIKit
import SnapKit

final class ScheduleCell: UITableViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .systemBlue
        
        return switcher
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        contentView.backgroundColor = UIColor.backgroundDay
        contentView.addSubview(label)
        contentView.addSubview(switcher)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(26.5)
        }
        
        switcher.snp.makeConstraints { make in
            make.height.equalTo(31)
            make.width.equalTo(51)
            make.top.bottom.equalToSuperview().inset(22)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
