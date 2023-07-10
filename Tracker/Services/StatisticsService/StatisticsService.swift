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
        let statisticsServiceHelper = StatisticsServiceHelper()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let countOfPerfectDays = statisticsServiceHelper.getCountOfPerfectDays()
        let bestSeries = statisticsServiceHelper.getBestSeries()
        let averageValue = countAverageValue(records: records, dateFormatter)
        
        statisticsModel = TrackersStatistics(completedDays: records.count,
                                             perfectDays: countOfPerfectDays,
                                             bestSeries: bestSeries,
                                             averageValue: averageValue)
    }
    
    private func countAverageValue(records: [TrackerRecord], _ dateFormatter: DateFormatter) -> Int {
        let countOfDays = records.map({ dateFormatter.string(from: $0.date) }).count
        
        return records.count != 0 ? records.count / countOfDays : 0
    }
}
