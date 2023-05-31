//
//  NewHabitPresenter.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

enum KindOfTrackers {
    case habit
    case unregularEvent
}

final class NewTrackerPresenter: NewTrackerViewPresenterProtocol {
    
    var view: NewTrackerViewControllerProtocol?
    
    let buttonsTitleForTableView = ["Категория", "Расписание"]
    
    private let storage = TrackerStorageService.shared
    
    func createNewTracker() -> [TrackerCategory] {
        guard let categoryArray = storage.categories,
              let trackerName = storage.trackerName,
              let trackerColor = storage.trackerColor,
              let trackerEmoji = storage.trackerEmoji else { return [] }
        
        let tracker = Tracker(id: UUID(),
                              name: trackerName,
                              color: trackerColor,
                              emoji: trackerEmoji,
                              schedule: storage.trackerSchedule ?? [1,2,3,4,5,6,7])
        
        var newCategoryArray: [TrackerCategory] = []
        
        categoryArray.forEach { category in
            if storage.selectedCategoryString == category.name {
                var newTrackersArray = category.trackerDictionary
                newTrackersArray.append(tracker)
                newCategoryArray.append(TrackerCategory(name: category.name, trackerDictionary: newTrackersArray))
            } else {
                newCategoryArray.append(category)
            }
        }
        
        return newCategoryArray
    }
    
    func checkCreateButtonToUnclock() {
        if storage.trackerName != nil &&
            storage.trackerColor != nil &&
            storage.trackerEmoji != nil &&
            storage.selectedCategoryString != nil {
            switch view?.kindOfTracker {
            case .unregularEvent:
                view?.unlockCreateButton()
            case .habit:
                storage.selectedScheduleString != nil ? view?.unlockCreateButton() : view?.lockCreateButton()
            default:
                view?.lockCreateButton()
            }
        } else {
            view?.lockCreateButton()
        }
    }
}
