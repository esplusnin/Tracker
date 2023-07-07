//
//  AnalyticService.swift
//  Tracker
//
//  Created by Евгений on 06.07.2023.
//

import Foundation
import YandexMobileMetrica

enum Events: String {
    case open = "open"
    case close = "close"
    case click = "click"
}

enum Screen: String {
    case trackersVC = "TrackersVC"
    case creatingVC = "CreatingVC"
    case newTrackerVC = "NewTrackerVC"
    case categoryVC = "CategoryVC"
    case scheduleVC = "ScheduleVC"
    case statisticsVC = "StatisticsVC"
    case editingCategory = "EditingCategoryVC"
    case editingTrackerVC = "EditingTrackerVC"
    case filterVC = "FilterVC"
}

enum Item: String {
    // TrackerVC:
    case addTrack = "add_track"
    case track = "track"
    case filter = "filter"
    case edit = "edit"
    case delete = "delete"
    
    // CreatingVC:
    case habit = "habit"
    case unregularEvent = "unregularEvent"
    
    // NewTrackerVC:
    case category = "category"
    case schedule = "schedule"
    case emoji = "emoji"
    case color = "color"
    case create = "create"
    case cancel = "cancel"
    case nameDidEnter = "nameDidEnter"
    
    // Schedule:
    case everyDay = "everyDay"
    case notEveryDay = "notEveryDay"
    
    // FilterVC:
    case allTrackers = "allTrackers"
    case todaysTrackers = "todaysTrackers"
    case completedTrackers = "completedTrackers"
    case uncompletedTrackers = "uncompletedTrackers"
    
    // EditingTrackerVC
    case decreaseDays = "decreaseDays"
    case increaseDays = "increaseDays"
}

final class AnalyticsService {
    
    static let instance = AnalyticsService()

    private init() {}
    
    func sentEvent(typeOfEvent: Events, screen: Screen, item: Item?) {
        var parameters: [AnyHashable: Any] = [:]
        
        if item == nil {
            parameters = ["event": typeOfEvent.rawValue, "screen": screen.rawValue]
        } else {
            guard let item = item else { return }
            parameters = ["event": typeOfEvent.rawValue, "screen": screen.rawValue, "item": item.rawValue]
        }
        YMMYandexMetrica.reportEvent("EVENT", parameters: parameters) { error in
            print("DID FAIL REPORT EVENT: %@")
            print("REPORT ERROR: %@", error.localizedDescription)
        }
    }
}
