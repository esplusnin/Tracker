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
        viewModel.isStatisticsExists()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analyticsService.sentEvent(typeOfEvent: .open, screen: .statisticsVC, item: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        analyticsService.sentEvent(typeOfEvent: .close, screen: .statisticsVC, item: nil)
    }
    
    func bind() {
        viewModel.$isStatisticsExist.bind { [weak self] value in
            guard let self = self else { return }
            self.isStatisticExist(value: value)
        }
        
        viewModel.$recordsModel.bind { [weak self] model in
            guard let self = self else { return }
            statisticView.bestPeriod.setCountLabel(value: String(model?.bestSeries ?? 0))
            statisticView.perfectDays.setCountLabel(value: String(model?.perfectDays ?? 0))
            statisticView.completedTrackersView.setCountLabel(value: String(model?.completedDays ?? 0))
            statisticView.averageDays.setCountLabel(value: String(model?.averageValue ?? 0))
        }
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
        statisticView.completedTrackersView.removeFromSuperview()
        
        view.addSubview(statisticView.emptyStatisticImageView)
        view.addSubview(statisticView.emptyStatisticLabel)
    }
    
    private func setStatisticsViews() {
        statisticView.emptyStatisticImageView.removeFromSuperview()
        statisticView.emptyStatisticLabel.removeFromSuperview()
        
        view.addSubview(statisticView.bestPeriod)
        view.addSubview(statisticView.perfectDays)
        view.addSubview(statisticView.completedTrackersView)
        view.addSubview(statisticView.averageDays)
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
        statisticView.bestPeriod.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
        }
        
        statisticView.perfectDays.snp.makeConstraints { make in
            make.top.equalTo(statisticView.bestPeriod.snp.bottom).inset(-12)
        }
        
        statisticView.completedTrackersView.snp.makeConstraints { make in
            make.top.equalTo(statisticView.perfectDays.snp.bottom).inset(-12)
        }
        
        statisticView.averageDays.snp.makeConstraints { make in
            make.top.equalTo(statisticView.completedTrackersView.snp.bottom).inset(-12)
        }
        
        [statisticView.bestPeriod, statisticView.perfectDays,
         statisticView.completedTrackersView, statisticView.averageDays].forEach { view in
            view.snp.makeConstraints { make in
                make.height.equalTo(90)
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }
}
