//
//  StatisticsServiceProtocol.swift
//  Tracker
//
//  Created by Евгений on 10.07.2023.
//

import Foundation

protocol StatisticsServiceProtocol: AnyObject {
    var statisticsModel: TrackersStatistics? { get }
    func provideStatisticsModel(records: [TrackerRecord]?)
}
