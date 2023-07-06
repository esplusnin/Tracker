//
//  StatisticView.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class StatisticView {
    
    lazy var emptyStatisticImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.statisticIsEmpty
        
        return imageView
    }()
    
    lazy var emptyStatisticLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableConstants.StatisticsVC.nothingToAnalyze
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.blackDay
        
        return label
    }()
    
    lazy var totalCompletedTrackerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.cornerRadius = 16
        view.backgroundColor = .whiteDay
        
        return view
    }()
    
    lazy var countOfCompletedTrackersLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 34)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var completedTrackersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Трекеров завершено"
        
        return label
    }()
}
