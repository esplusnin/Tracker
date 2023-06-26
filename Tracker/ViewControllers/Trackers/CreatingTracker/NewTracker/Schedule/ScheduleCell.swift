//
//  ScheduleCell.swift
//  Tracker
//
//  Created by Евгений on 23.05.2023.
//

import UIKit
import SnapKit

final class ScheduleCell: UITableViewCell {
    
    weak var delegate: ScheduleViewControllerDelegate?
    
    var viewModel: String? {
        didSet {
            label.text = viewModel
        }
    }
    
    lazy var label = UILabel()
    
    lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .systemBlue
        switcher.addTarget(self, action: #selector(controlSchedule), for: .allTouchEvents)
        
        return switcher
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setViews()
        setConstraints()
    }
    
    @objc private func controlSchedule() {
        delegate?.controlScheduleDay(self)
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
