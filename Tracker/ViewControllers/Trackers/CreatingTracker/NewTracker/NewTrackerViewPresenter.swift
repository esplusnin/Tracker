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

final class NewTrackerViewPresenter: NewTrackerViewPresenterProtocol {
    
    var view: NewTrackerViewControllerProtocol?
    
    let buttonsTitleForTableView = ["Категория", "Расписание"]
    
    func createNewTracker() -> [TrackerCategory] {
        guard let categoryArray = view?.trackerPresenter?.categories,
              let trackerName = view?.trackerName,
              let trackerColor = view?.trackerColor,
              let trackerEmoji = view?.trackerEmoji else { return [] }
        
        let tracker = Tracker(id: UUID(),
                              name: trackerName,
                              color: trackerColor,
                              emoji: trackerEmoji,
                              schedule: view?.trackerSchedule ?? nil)
        
        var newCategoryArray: [TrackerCategory] = []
        
        categoryArray.forEach { category in
            if view?.selectedCategoryString == category.name {
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
        view?.trackerName != nil &&
        view?.trackerColor != nil &&
        view?.trackerEmoji != nil &&
        view?.selectedCategoryString != nil &&
        view?.selectedScheduleString != nil ? view?.unlockCreateButton() : view?.lockCreateButton()
    }
}
