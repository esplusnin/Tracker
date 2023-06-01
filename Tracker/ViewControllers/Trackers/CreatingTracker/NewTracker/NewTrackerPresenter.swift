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
    
    private let trackerStorage = TrackerStorageService.shared
    
    func createNewTracker() -> [TrackerCategory] {
        guard let categoryArray = trackerStorage.categories,
              let trackerName = trackerStorage.trackerName,
              let trackerColor = trackerStorage.trackerColor,
              let trackerEmoji = trackerStorage.trackerEmoji else { return [] }
        
        let tracker = Tracker(id: UUID(),
                              name: trackerName,
                              color: trackerColor,
                              emoji: trackerEmoji,
                              schedule: trackerStorage.trackerSchedule ?? [1,2,3,4,5,6,7])
        
        var newCategoryArray: [TrackerCategory] = []
        
        categoryArray.forEach { category in
            if trackerStorage.selectedCategoryString == category.name {
                var newTrackersArray = category.trackerDictionary
                newTrackersArray.append(tracker)
                newCategoryArray.append(TrackerCategory(name: category.name, trackerDictionary: newTrackersArray))
            } else {
                newCategoryArray.append(category)
            }
        }
        
        return newCategoryArray
    }
    
    @objc func checkCreateButtonToUnclock() {
        if trackerStorage.trackerName != nil &&
            trackerStorage.trackerColor != nil &&
            trackerStorage.trackerEmoji != nil &&
            trackerStorage.selectedCategoryString != nil {
            switch view?.kindOfTracker {
            case .unregularEvent:
                view?.unlockCreateButton()
            case .habit:
                trackerStorage.selectedScheduleString != nil ? view?.unlockCreateButton() : view?.lockCreateButton()
            default:
                view?.lockCreateButton()
            }
        } else {
            view?.lockCreateButton()
        }
    }
    
    func resetTrackerInfoAfterDeselect(section: Int) {
        switch section {
        case 0:
            trackerStorage.trackerEmoji = nil
        case 1:
            trackerStorage.trackerColor = nil
        default:
            return
        }
    }
}
