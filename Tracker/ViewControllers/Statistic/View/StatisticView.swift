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
    
    lazy var bestPeriod: StatisticsBlockView = {
        let view = StatisticsBlockView()
        view.setDescriptionLabel(value: LocalizableConstants.StatisticsVC.bestPeriod)
        
        return view
    }()
    
    lazy var perfectDays: StatisticsBlockView = {
        let view = StatisticsBlockView()
        view.setDescriptionLabel(value: LocalizableConstants.StatisticsVC.perfectDays)
        
        return view
    }()
    
    lazy var completedTrackersView: StatisticsBlockView = {
        let view = StatisticsBlockView()
        view.setDescriptionLabel(value: LocalizableConstants.StatisticsVC.totalCompletedTracker)
        
        return view
    }()
    
    lazy var averageDays:  StatisticsBlockView = {
        let view = StatisticsBlockView()
        view.setDescriptionLabel(value: LocalizableConstants.StatisticsVC.averageValue)
        
        return view
    }()
}
