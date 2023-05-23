//
//  NewHabitCollectionCell.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class NewHabitCollectionCell: UICollectionViewCell {
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var colorSectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        setViews()
    //        setConstraints()
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    func setFirstSection() {
        setFirstSectionViews()
        setFirstSectionConstraints()
    }
    
    private func setFirstSectionViews() {
        contentView.addSubview(emojiLabel)
    }
    
    private func setFirstSectionConstraints() {
        emojiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setSecondSection() {
        setSecondSectionViews()
        setSecondSectionConstraints()
    }
    
    private func setSecondSectionViews() {
        contentView.addSubview(colorSectionImageView)
    }
    
    private func setSecondSectionConstraints() {
        colorSectionImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
