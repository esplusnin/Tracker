//
//  FilterViewModel.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import Foundation

final class FilterViewModel {
    
    private let dataProvider = DataProviderService.instance
    
    private(set) var availableFilters: [String] = [
        LocalizableConstants.FilterVC.allTrackers,
        LocalizableConstants.FilterVC.todaysTrackers,
        LocalizableConstants.FilterVC.completedTrackers,
        LocalizableConstants.FilterVC.uncompletedTrackers
    ]
    
    func getCurrentFilter() -> String {
        dataProvider.currentFilter ?? ""
    }
    
    func setCurrentFilter(selected: String) {        
        dataProvider.currentFilter = selected
    }
}
