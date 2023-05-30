//
//  SupplementaryView.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class SupplementaryView: UICollectionReusableView {
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = UIColor.blackDay
        label.textAlignment = .left
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(10)
            make.centerY.equalToSuperview()
            make.bottom.equalTo(snp.bottom).inset(12)
            make.leading.equalTo(snp.leading).inset(28)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
