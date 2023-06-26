//
//  NewCategoryCell.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    var titleLabel = UILabel()
    
    var viewModel: String? {
        didSet {
            titleLabel.text = viewModel
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.backgroundDay
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
}
