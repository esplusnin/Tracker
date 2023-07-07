//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Евгений on 21.05.2023.
//

import UIKit
import SnapKit

final class StatisticViewController: UIViewController {
    
    private(set) var statisticView = StatisticView()
    private let viewModel = StatisticsViewModel()
    private let analyticsService = AnalyticsService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteDay
        
        setDumbs()
        setDumbsConstraints()
        setNavBar()
        bind() 
        viewModel.checkIsStatisticsExist()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analyticsService.sentEvent(typeOfEvent: .open, screen: .statisticsVC, item: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        analyticsService.sentEvent(typeOfEvent: .close, screen: .statisticsVC, item: nil)
    }
    private func bind() {
        viewModel.$isStatisticsExist.bind { [weak self] value in
            guard let self = self else { return }
            self.isStatisticExist(value: value)
        }
        
        viewModel.$totalCountOfCompletedTrackers.bind { [weak self] newValue in
            guard let self = self else { return }
            self.setCompletedTrackerslabel(newValue)
        }
    }
    
    private func setCompletedTrackerslabel(_ newValue: Int?) {
        guard let newValue = newValue else { return }
        statisticView.countOfCompletedTrackersLabel.text = String(newValue)
    }
    
    private func isStatisticExist(value: Bool?) {
        guard let value = value else { return }
        if value == true {
            setStatisticsViews()
            setStatisticsViewsConstraints()
        } else {
            setDumbs()
            setDumbsConstraints()
        }
    }
}

// MARK: Set views:
extension StatisticViewController {
    private func setDumbs() {
        statisticView.totalCompletedTrackerView.removeFromSuperview()
        
        view.addSubview(statisticView.emptyStatisticImageView)
        view.addSubview(statisticView.emptyStatisticLabel)
    }
    
    private func setStatisticsViews() {
        statisticView.emptyStatisticImageView.removeFromSuperview()
        statisticView.emptyStatisticLabel.removeFromSuperview()
        
        view.addSubview(statisticView.totalCompletedTrackerView)
        statisticView.totalCompletedTrackerView.addSubview(statisticView.countOfCompletedTrackersLabel)
        statisticView.totalCompletedTrackerView.addSubview(statisticView.completedTrackersLabel)
    }
    
    private func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = LocalizableConstants.StatisticsVC.title
    }
}
    
// MARK: Set constraints:
extension StatisticViewController {
    private func setDumbsConstraints() {
        statisticView.emptyStatisticImageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        statisticView.emptyStatisticLabel.snp.makeConstraints { make in
            make.top.equalTo(statisticView.emptyStatisticImageView.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setStatisticsViewsConstraints() {
        statisticView.totalCompletedTrackerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.height.equalTo(90)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        statisticView.countOfCompletedTrackersLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12)
        }
        
        statisticView.completedTrackersLabel.snp.makeConstraints { make in
            make.top.equalTo(statisticView.countOfCompletedTrackersLabel.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview().inset(12)
        }
    }
}
