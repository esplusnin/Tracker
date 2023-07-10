//
//  StatisticsBlockView.swift
//  Tracker
//
//  Created by Евгений on 10.07.2023.
//

import UIKit
import SnapKit

class StatisticsBlockView: UIView {
    var blockView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.cornerRadius = 16
        view.backgroundColor = .whiteDay
        
        return view
    }()
    
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
        addSubview(blockView)
        blockView.addSubview(countLabel)
        blockView.addSubview(descriptionLabel)
    }
    
    private func setConstraints() {
        blockView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12)
        }
        
       descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview().inset(12)
        }
    }
}
