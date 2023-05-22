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
        label.text = "Что будем отслеживать?"
        label.textAlignment = .center
        label.textColor = UIColor.blackDay
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var addTrackerButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.blackDay
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Resources.Images.plus, for: .normal)
        
        return button
    }()
    
    lazy var navigationBarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        
        return label
    }()
    
    lazy var navigationBarDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.layer.cornerRadius = 8
        
        return datePicker
    }()
    
    lazy var searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.placeholder = "Поиск..."
        textField.textColor = UIColor.gray
        
        return textField
    }()
    
    lazy var trackersCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        
        return collection
    }()
}
