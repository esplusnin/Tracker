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
    private(set) var isStatisticsExist: Bool?
    @Observable
    private(set) var recordsModel: TrackersStatistics?
    
    init() {
        dataProviderService.bindStatisticsViewModel(controller: self)
    }
    
    func isStatisticsExists() {
        let statisticsModel = dataProviderService.getRecordsStatisticsModel()
        if statisticsModel.completedDays != 0 {
            isStatisticsExist = true
            recordsModel = statisticsModel
        } else {
            isStatisticsExist = false
        }
    }
}
