//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Евгений on 21.05.2023.
//

import UIKit
import SnapKit

final class StatisticViewController: UIViewController {
    
    private let statisticView = StatisticView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setNavBar()
        setConstraints()
    }
    
    private func setViews() {
        view.backgroundColor = .white

        view.addSubview(statisticView.emptyStatisticImageView)
        view.addSubview(statisticView.emptyStatisticLabel)
    }
    
    private func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = LocalizableConstants.Statistics.title
    }
    
    private func setConstraints() {
        statisticView.emptyStatisticImageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        statisticView.emptyStatisticLabel.snp.makeConstraints { make in
            make.top.equalTo(statisticView.emptyStatisticImageView.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}
