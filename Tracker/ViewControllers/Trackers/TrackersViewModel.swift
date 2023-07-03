//
//  TrackersViewModel.swift
//  Tracker
//
//  Created by Евгений on 22.06.2023.
//

import Foundation

struct AdditionTrackerInfo {
    var buttonString: String
    var countOfDays: String
    var isCompleteToday: Bool
    var isTodayFuture: Bool
}

final class TrackersViewModel: TrackersViewModelProtocol {
    
    @Observable
    private(set) var visibleTrackers: [TrackerCategory] = []
    @Observable
    private(set) var isRecordUpdate: Bool?
    @Observable
    private(set) var isVisibleCategoryEmpty: Bool?
    @Observable
    private(set) var isVisibleCategoryEmptyAfterSearch: Bool?
    
    private let dataProviderService = DataProviderService.instance
    
    var additionTrackerInfo: AdditionTrackerInfo?
    var currentDate: Date?
    
    init() {
        dataProviderService.trackerStore = TrackerStore()
        dataProviderService.trackerCategoryStore = TrackerCategoryStore()
        dataProviderService.trackerRecordStore = TrackerRecordStore()
        
        dataProviderService.inizializeVisibleCategories()
        dataProviderService.getCategoryNames()
        dataProviderService.setAllTrackerRecords()
        dataProviderService.bindTrackersViewModel(controller: self)
    }
    
    func setVisibleTrackersFromProvider() {
        visibleTrackers = dataProviderService.getVisiblieCategories()
        
        if visibleTrackers.count == 0 {
            isVisibleCategoryEmpty = true
        }
    }
    
    func updateVisibleTrackersAfterSearch(filledName: String) {
        let trackers = searchTrackerByName(categories: visibleTrackers, filledName: filledName)
        visibleTrackers = trackers
        
        if trackers.count == 0 {
            isVisibleCategoryEmptyAfterSearch = true
        }
    }
    
    func recordDidUpdate() {
        isRecordUpdate = true
    }
    
    func editTracker(id: UUID) {
        dataProviderService.editTrackerFromStore(id: id)
    }
    
    func deleteTracker(id: UUID) {
        dataProviderService.deleteTrackerFromStore(id: id)
    }
    
    func fillAdditionalInfo(id: UUID) {
        let completeDayString = setCellButtonIfTrackerWasCompletedToday(id: id)
        let countOfDays = countAmountOfCompleteDays(id: id)
        let daysString = LocalizableConstants.TrackerVC.countOfCompletedDays(countOfDays: countOfDays)
        let isCompleteToday = completeDayString == "+" ? false : true
        let isTodayFuture = checkCurrentDateIsFuture()
        
        additionTrackerInfo = AdditionTrackerInfo(buttonString: completeDayString,
                                                  countOfDays: daysString,
                                                  isCompleteToday: isCompleteToday,
                                                  isTodayFuture: isTodayFuture)
    }
    
    private func setCellButtonIfTrackerWasCompletedToday(id: UUID) -> String {
        var string = "+"
        let completedTrackers = dataProviderService.getTrackerRecords()
        
        completedTrackers.forEach({ trackers in
            if trackers.id == id && currentDate == trackers.date {
                string = "✓"
            }
        })
        
        return string
    }
    
    private func countAmountOfCompleteDays(id: UUID) -> Int {
        var counter = 0
        let completedTrackers = dataProviderService.getTrackerRecords()
        
        completedTrackers.forEach({ trackerRecord in
            if trackerRecord.id == id {
                counter += 1
            }
        })
        
        return counter
    }
    
    private func checkCurrentDateIsFuture() -> Bool {
        guard let currentDate = currentDate else { return false }
        let date = Date()
        
        return date > currentDate
    }
    
    func changeStatusTrackerRecord(model: TrackerRecord, isAddDay: Bool) {
        dataProviderService.changeStatusTrackerRecord(model: model, isAddDay: isAddDay)
    }
    
    func showNewTrackersAfterChangeDate() {
        dataProviderService.inizializeVisibleCategories()
        guard let date = currentDate else { return }
        
        setVisibleTrackersFromProvider()
        var newArray: [TrackerCategory] = []
        
        for category in visibleTrackers {
            var newCategory = TrackerCategory(name: category.name, trackerDictionary: [])
            
            for tracker in category.trackerDictionary {
                guard let schedule = tracker.schedule else { return }
                let trackerDate = DateService().getNumberOfCurrentDate(date)
                
                if schedule.contains(trackerDate) {
                    newCategory.trackerDictionary.append(tracker)
                }
            }
            if !newCategory.trackerDictionary.isEmpty {
                newArray.append(newCategory)
            }
        }
        
        visibleTrackers = newArray
    }
    
    private func searchTrackerByName(categories: [TrackerCategory], filledName: String) -> [TrackerCategory] {
        var newVisibleArray: [TrackerCategory] = []
        
        for category in categories {
            var newCategory = TrackerCategory(name: category.name, trackerDictionary: [])
            
            for tracker in category.trackerDictionary {
                if tracker.name.contains(filledName) {
                    newCategory.trackerDictionary.append(tracker)
                }
            }
            
            if !newCategory.trackerDictionary.isEmpty {
                newVisibleArray.append(newCategory)
            }
        }
        
        return newVisibleArray
    }
}
