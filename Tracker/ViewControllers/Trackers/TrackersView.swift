//
//  TrackersView.swift
//  Tracker
//
//  Created by Евгений on 21.05.2023.
//

import UIKit

final class TrackersView {
    lazy var emptyTrackersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.trackersIsEmpty
        
        return imageView
    }()
    
    lazy var emptyTrackersLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableConstants.TrackerVC.emptyStateLabel
        label.textAlignment = .center
        label.textColor = .blackDay
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var addTrackerButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .blackDay
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Resources.Images.addTracker, for: .normal)
        
        return button
    }()
    
    lazy var navigationBarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableConstants.TrackerVC.title
        label.font = .boldSystemFont(ofSize: 34)
        
        return label
    }()
    
    lazy var navigationBarDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru-RU")
        datePicker.layer.cornerRadius = 8
        
        return datePicker
    }()
    
    lazy var searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.clearButtonMode = .never
        textField.returnKeyType = .go
        textField.placeholder = LocalizableConstants.TrackerVC.searchFieldPlaceholder
        textField.textColor = .blackDay
        
        return textField
    }()
    
    lazy var trackersCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    lazy var cancelationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizableConstants.TrackerVC.cancelationButton, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        
        return button
    }()
}
