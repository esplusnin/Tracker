//
//  FilterViewModel.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import Foundation

final class FilterViewModel {
    
    private let dataProviderService = DataProviderService.instance
    
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
    }
}
