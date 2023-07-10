//
//  StatisticsService.swift
//  Tracker
//
//  Created by Евгений on 10.07.2023.
//

import Foundation

final class StatisticsService: StatisticsServiceProtocol {
    
    private let dataProviderService = DataProviderService.instance
    
    var statisticsModel: TrackersStatistics? {
        didSet {
            dataProviderService.statisticsDidUpdate()
        }
    }
    
    
    func provideStatisticsModel(records: [TrackerRecord]?) {
        guard let records = records else { return }
        
        let averageValue = countAverageValue(records: records)
        
        statisticsModel = TrackersStatistics(completedDays: records.count,
                                             perfectDays: 0,
                                             bestSeries: 0,
                                             averageValue: averageValue)
    }
    
    private func countAverageValue(records: [TrackerRecord]) -> Int {
        let datesArray = records.map({ $0.date })
        
        let calendar = Calendar.current
        let days = datesArray.reduce(0) { (result, date) -> Int in
            let components = calendar.dateComponents([.day], from: date)
            return result + (components.day ?? 0)
        }
        
        return records.count / days
    }
}
