//
//  trackerCell.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class TrackerCell: UICollectionViewCell {
    
    weak var delegate: TrackersCollectionViewCellDelegate?
    
    var trackerModel: Tracker? {
        didSet {
            guard let trackerModel = trackerModel else { return }
            cellView.backgroundColor = trackerModel.color
            trackerLabel.text = trackerModel.name
            emojiLabel.text = trackerModel.emoji
            completeTrackerDayButton.backgroundColor = trackerModel.color
        }
    }
    
    var additionalTrackerInfo: AdditionTrackerInfo? {
        didSet {
            guard let additionalTrackerInfo = additionalTrackerInfo else { return }
            completeTrackerDayButton.setTitle(additionalTrackerInfo.buttonString, for: .normal)
            numberOfDaysLabel.text = additionalTrackerInfo.countOfDaysString
            if additionalTrackerInfo.isTodayFuture {
                unlockCompleteButton()
                completeTrackerDayButton.alpha = additionalTrackerInfo.isCompleteToday ? 0.5 : 1
            } else {
                lockCompleteButton()
            }
        }
    }
    
    var isTrackerPinned: Bool? {
        didSet {
            guard let isTrackerPinned = isTrackerPinned else { return }
            
            switch isTrackerPinned {
            case true:
                pinCommandString = LocalizableConstants.ContextMenuVC.unfix
            case false:
                pinCommandString = LocalizableConstants.ContextMenuVC.fix
            }
        }
    }
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
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
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var numberOfDaysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .blackDay
        
        return label
    }()
    
    lazy var completeTrackerDayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 17
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.whiteDay, for: .normal)
        
        return button
    }()
    
    lazy var pinSingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pin.fill")
        imageView.tintColor = .white
        
        return imageView
    }()
    
    lazy var pinCommandString = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        setTarget()
        
        addContextMenuInteraction()
        
        doAnimate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.layer.shadowOpacity = 0
        self.contentView.layer.shadowOffset = CGSize.zero
        self.contentView.layer.shadowRadius = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        doAnimate()
    }
    
    func lockCompleteButton() {
        completeTrackerDayButton.backgroundColor = .colorSelection1
        completeTrackerDayButton.isEnabled = false
        completeTrackerDayButton.setTitle("✕", for: .normal)
        completeTrackerDayButton.titleLabel?.font = .systemFont(ofSize: 15)
        completeTrackerDayButton.alpha = 0.4
    }
    
    func unlockCompleteButton() {
        completeTrackerDayButton.alpha = 1
        completeTrackerDayButton.isEnabled = true
    }
    
    private func doAnimate() {
        UIView.animate(withDuration: 1, delay: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.contentView.layer.shadowColor = UIColor.gray.cgColor
            self.contentView.layer.shadowOpacity = 0.5
            self.contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
            self.contentView.layer.shadowRadius = 4
        })
    }
    
    private func setTarget() {
        completeTrackerDayButton.addTarget(self, action: #selector(completeTrackerToday), for: .touchUpInside)
    }
    
    private func pinTracker(from cell: TrackerCell) {
        delegate?.pinTracker(from: cell)
    }
    
    private func unpinTracker(from cell: TrackerCell) {
        delegate?.unpinTracker(from: cell)
    }
    
    private func editTracker(from cell: TrackerCell) {
        delegate?.editTracker(from: cell)
    }
    
    private func deleteTracker(from cell: TrackerCell) {
        delegate?.deleteTracker(from: cell)
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
}

extension TrackerCell: UIContextMenuInteractionDelegate {
    func addContextMenuInteraction() {
        let interaction = UIContextMenuInteraction(delegate: self)
        cellView.addInteraction(interaction)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let isTrackerPinned = isTrackerPinned else { return UIContextMenuConfiguration() }
        
        let pinImage = isTrackerPinned ? UIImage(systemName: "pin.slash") : UIImage(systemName: "pin.fill")
        let editImage = UIImage(systemName: "square.and.pencil")
        let removeImage = UIImage(systemName: "trash")
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let pinAction = UIAction(title: self.pinCommandString,
                                     image: pinImage) { [weak self] _ in
                guard let self = self, let isTrackerPinned = self.isTrackerPinned  else { return }
                isTrackerPinned ? self.unpinTracker(from: self) : self.pinTracker(from: self)
            }
            
            let editAction = UIAction(title: LocalizableConstants.ContextMenuVC.edit,
                                      image: editImage) { [weak self] action in
                guard let self = self else { return }
                self.editTracker(from: self)
            }
            
            let deleteAction = UIAction(title: LocalizableConstants.ContextMenuVC.remove,
                                        image: removeImage, attributes: .destructive) { [weak self] action in
                guard let self = self else { return }
                self.deleteTracker(from: self)
            }
            
            return UIMenu(children: [pinAction, editAction, deleteAction])
        }
    }
}

// MARK: Setting Views:
extension TrackerCell {
    private func setViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(emojiImageView)
        cellView.addSubview(emojiLabel)
        cellView.addSubview(trackerLabel)
        cellView.addSubview(pinSingImageView)
        contentView.addSubview(numberOfDaysLabel)
        contentView.addSubview(completeTrackerDayButton)
    }
}

// MARK: Setting Layout:
extension TrackerCell {
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
        
        pinSingImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.centerY.equalTo(emojiImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
