//
//  TrackersViewModel.swift
//  Tracker
//
//  Created by Евгений on 22.06.2023.
//

import Foundation

struct AdditionTrackerInfo {
    var buttonString: String
    var countOfDays: Int
    var countOfDaysString: String
    var isCompleteToday: Bool
    var isTodayFuture: Bool
    var categoryName: String?
}

final class TrackersViewModel: TrackersViewModelProtocol {
    
    private let dataProviderService = DataProviderService.instance
    
    var additionTrackerInfo: AdditionTrackerInfo?
    var currentDate: Date?
    
    @Observable
    private(set) var visibleTrackers: [TrackerCategory] = []
    @Observable
    private(set) var isRecordUpdate: Bool?
    @Observable
    private(set) var isVisibleCategoryEmpty: Bool?
    @Observable
    private(set) var isVisibleCategoryEmptyAfterSearch: Bool?
    @Observable
    private(set) var isNeedToChangeDate: Bool?
    private var pinnedTrackers: [Tracker] = []
        
    init() {
        dataProviderService.trackerStore = TrackerStore()
        dataProviderService.trackerCategoryStore = TrackerCategoryStore()
        dataProviderService.trackerRecordStore = TrackerRecordStore()
        dataProviderService.statisticsService = StatisticsService()
        
        dataProviderService.inizializeVisibleCategories()
        dataProviderService.updateCategoryNames()
        dataProviderService.setAllTrackerRecords()
        dataProviderService.bindTrackersViewModel(controller: self)
    }
    // MARK: - Wrapped propertie's rules:
    func recordDidUpdate() {
        isRecordUpdate = true
    }
    
    func todaysFilterDidEnable() {
        isNeedToChangeDate = true
    }
    
    // MARK: - Operating with arrays:
    func setVisibleTrackersFromProvider() {
        if isPinnedTrackersExist() {
            getVisibleTrackersWithPinned()
        } else {
            showNewTrackersAfterChangeDate()
        }
        
        if visibleTrackers.count == 0 {
            isVisibleCategoryEmpty = true
        }
    }
    
    func getVisibleTrackersWithPinned() {
        var trackerCategories = dataProviderService.getVisiblieCategories()
        
        if let index = trackerCategories.firstIndex(where: { $0.name == L10n.TrackerVC.pinned }) {
            let pinnedTrackers = trackerCategories[index]
            trackerCategories.remove(at: index)
            trackerCategories.insert(pinnedTrackers, at: 0)
            visibleTrackers = trackerCategories
        } else {
            return
        }
    }
    
    func updateVisibleTrackersAfterSearch(filledName: String) {
        let trackers = searchTrackerByName(categories: visibleTrackers, filledName: filledName)
        visibleTrackers = trackers
        
        if trackers.count == 0 {
            isVisibleCategoryEmptyAfterSearch = true
        }        
    }
    
    func showNewTrackersAfterChangeDate() {
        let trackers = dataProviderService.getVisiblieCategories()
        
        guard let date = currentDate else { return }
        
        var newArray: [TrackerCategory] = []
        
        for category in trackers {
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
        
        if visibleTrackers.count == 0 {
            isVisibleCategoryEmpty = true
        }
    }
    
    func updateVisibleTrackers(isCompleted: Bool) {
        var newArray: [TrackerCategory] = []
        let completeLabel = isCompleted ? "✓" : "+"
        
        for category in visibleTrackers {
            var newCategory = TrackerCategory(name: category.name, trackerDictionary: [])
            
            for tracker in category.trackerDictionary {
                if setCellButtonIfTrackerWasCompletedToday(id: tracker.id) == completeLabel {
                    newCategory.trackerDictionary.append(tracker)
                }
            }
            
            if !newCategory.trackerDictionary.isEmpty {
                newArray.append(newCategory)
            }
        }
        
        visibleTrackers = newArray
    }
    
    // MARK: - Tracker's actions:
    func editTracker(trackerID: UUID) {
        dataProviderService.editTrackerFromStore(trackerID)
    }
    
    func deleteTracker(id: UUID) {
        dataProviderService.deleteTrackerFromStore(id: id)
    }
    
    func pinTracker(_ trackerID: UUID) {
        let pinnedName = L10n.TrackerVC.pinned
        if visibleTrackers[0].name != pinnedName {
            dataProviderService.addCategoryToStore(name: pinnedName)
            dataProviderService.pinTracker(trackerID)
        } else {
            dataProviderService.pinTracker(trackerID)
        }
    }
    
    func unpinTracker(_ trackerID: UUID) {
        dataProviderService.unpinTracker(trackerID)
    }
    
    func changeCountOfPerfectDays(isAdd: Bool) {
        guard let date = currentDate else { return }
        let statisticsTool = StatisticsServiceHelper()

        isAdd ? statisticsTool.setNewPerfectDaysValue(date: date) : statisticsTool.removePerfectDays(date: date)
    }
    
    func fillAdditionalInfo(id: UUID) {
        let completeDayString = setCellButtonIfTrackerWasCompletedToday(id: id)
        let countOfDays = countAmountOfCompleteDays(id: id)
        let countOfDaysString = L10n.numberOfDays(countOfDays)
        let isCompleteToday = completeDayString == "+" ? false : true
        let isTodayFuture = checkCurrentDateIsFuture()
        
        additionTrackerInfo = AdditionTrackerInfo(buttonString: completeDayString,
                                                  countOfDays: countOfDays,
                                                  countOfDaysString: countOfDaysString,
                                                  isCompleteToday: isCompleteToday,
                                                  isTodayFuture: isTodayFuture)
    }
    
    func changeStatusTrackerRecord(model: TrackerRecord, isAddDay: Bool) {
        dataProviderService.changeStatusTrackerRecord(model: model, isAddDay: isAddDay)
    }
    
    // MARK: - Helpers:
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
    
    private func isPinnedTrackersExist() -> Bool {
        dataProviderService.getVisiblieCategories().contains(where: { $0.name == L10n.TrackerVC.pinned })
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
