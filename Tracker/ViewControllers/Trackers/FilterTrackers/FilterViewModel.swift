//
//  FilterViewModel.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import Foundation

final class FilterViewModel {
    
    private let dataProviderService = DataProviderService.instance
    private let analyticsService = AnalyticsService.instance
    
    private(set) var availableFilters: [String] = [
        L10n.Filter.allTrackers,
        L10n.Filter.todaysTrackers,
        L10n.Filter.completedTrackers,
        L10n.Filter.uncompletedTrackers
    ]
    
    func getCurrentFilter() -> String {
        dataProviderService.currentFilter ?? ""
    }
    
    func setCurrentFilter(selected: String) {        
        dataProviderService.currentFilter = selected
        var eventName: Item
        
        switch selected {
        case L10n.Filter.allTrackers:
            eventName = Item.allTrackers
        case L10n.Filter.todaysTrackers:
            eventName = Item.todaysTrackers
        case L10n.Filter.completedTrackers:
            eventName = Item.completedTrackers
        case L10n.Filter.uncompletedTrackers:
            eventName = Item.uncompletedTrackers
        default:
            return
        }
        
        analyticsService.sentEvent(typeOfEvent: .click, screen: .filterVC, item: eventName)
    }
}
