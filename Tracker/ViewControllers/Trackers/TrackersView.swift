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
        label.textColor = UIColor.blackDay
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
}
