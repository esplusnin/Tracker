//
//  StatisticsBlockView.swift
//  Tracker
//
//  Created by Евгений on 10.07.2023.
//

import UIKit
import SnapKit

class StatisticsBlockView: UIView {
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 34)
        label.textAlignment = NSLocale.current.languageCode == "ar" ? .right : .left
        
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        
        self.backgroundColor = .whiteDay
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCountLabel(value: String) {
        countLabel.text = value
    }
    
    func setDescriptionLabel(value: String) {
        descriptionLabel.text = value
    }
    
    private func setViews() {
        addSubview(countLabel)
        addSubview(descriptionLabel)
    }
    
    private func setConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12)
        }
        
       descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview().inset(12)
        }
    }
}
