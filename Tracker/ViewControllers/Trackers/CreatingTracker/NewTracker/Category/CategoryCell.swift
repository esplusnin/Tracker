//
//  NewCategoryCell.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    var label = UILabel()
    
    var viewModel: String? {
        didSet {
            label.text = viewModel
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.backgroundDay
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        contentView.addSubview(label)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
}
