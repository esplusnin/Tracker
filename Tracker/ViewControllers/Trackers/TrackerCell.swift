//
//  trackerCell.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class TrackerCell: UICollectionViewCell {
    
    weak var delegate: TrackersViewControllerDelegate?
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var trackerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var emojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = UIColor.white
        imageView.layer.opacity = 0.3
        
        return imageView
    }()
    
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        
        return label
    }()
    
    lazy var numberOfDaysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .blackDay
        label.text = "0 дней"
        
        return label
    }()
    
    lazy var completeTrackerDayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 17
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        setConstraints()
        setTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTarget() {
        completeTrackerDayButton.addTarget(self, action: #selector(completeTrackerToday), for: .touchUpInside)
    }
    
    @objc private func completeTrackerToday() {
        if completeTrackerDayButton.titleLabel?.text == "+" {
            delegate?.addCurrentTrackerToCompletedThisDate(self, isAddDay: true)
            completeTrackerDayButton.setTitle("✓", for: .normal)
            completeTrackerDayButton.alpha = 0.5
        } else {
            delegate?.addCurrentTrackerToCompletedThisDate(self, isAddDay: false)
            completeTrackerDayButton.setTitle("+", for: .normal)
            completeTrackerDayButton.alpha = 1
        }
    }
    
    private func setViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(emojiImageView)
        cellView.addSubview(emojiLabel)
        cellView.addSubview(trackerLabel)
        contentView.addSubview(numberOfDaysLabel)
        contentView.addSubview(completeTrackerDayButton)
    }
    
    private func setConstraints() {
        cellView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        
        trackerLabel.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview().inset(12)
        }
        
        emojiImageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.leading.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(54)
        }
        
        emojiLabel.snp.makeConstraints { make in
            make.center.equalTo(emojiImageView)
        }
        
        numberOfDaysLabel.snp.makeConstraints { make in
            make.top.equalTo(cellView.snp.bottom).inset(-16)
            make.leading.equalTo(emojiLabel)
        }
        
        completeTrackerDayButton.snp.makeConstraints { make in
            make.height.width.equalTo(34)
            make.top.equalTo(cellView.snp.bottom).inset(-8)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalTo(numberOfDaysLabel.snp.centerY)
        }
    }
}
