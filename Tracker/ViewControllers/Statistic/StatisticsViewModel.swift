//
//  StatisticsViewModel.swift
//  Tracker
//
//  Created by Евгений on 05.07.2023.
//

import Foundation

final class StatisticsViewModel: StatisticsViewModelProtocol {
    
    private let dataProviderService = DataProviderService.instance
    
    @Observable
    private(set) var isStatisticsExist: Bool? {
        didSet {
            setCountOfTotalCompletedTrackers()
        }
    }
    @Observable
    private(set) var totalCountOfCompletedTrackers: Int?
    
    init() {
        dataProviderService.bindStatisticsViewModel(controller: self)
    }
    
    func checkIsStatisticsExist() {
        if dataProviderService.getTotalCompletedTrackers() != 0 {
            isStatisticsExist = true
        } else {
            isStatisticsExist = false
        }

    }
    
    private func setCountOfTotalCompletedTrackers() {
        totalCountOfCompletedTrackers = dataProviderService.getTotalCompletedTrackers()
    }
}
