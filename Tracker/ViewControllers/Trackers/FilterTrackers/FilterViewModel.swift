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
        LocalizableConstants.FilterVC.allTrackers,
        LocalizableConstants.FilterVC.todaysTrackers,
        LocalizableConstants.FilterVC.completedTrackers,
        LocalizableConstants.FilterVC.uncompletedTrackers
    ]
    
    func getCurrentFilter() -> String {
        dataProviderService.currentFilter ?? ""
    }
    
    func setCurrentFilter(selected: String) {        
        dataProviderService.currentFilter = selected
        var eventName: Item
        
        switch selected {
        case LocalizableConstants.FilterVC.allTrackers:
            eventName = Item.allTrackers
        case LocalizableConstants.FilterVC.todaysTrackers:
            eventName = Item.todaysTrackers
        case LocalizableConstants.FilterVC.completedTrackers:
            eventName = Item.completedTrackers
        case LocalizableConstants.FilterVC.uncompletedTrackers:
            eventName = Item.uncompletedTrackers
        default:
            return
        }
        
        analyticsService.sentEvent(typeOfEvent: .click, screen: .filterVC, item: eventName)
    }
}
