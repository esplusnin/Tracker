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
                              schedule: view?.trackerSchedule ?? [1,2,3,4,5,6,7])
        
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
        if view?.trackerName != nil &&
            view?.trackerColor != nil &&
            view?.trackerEmoji != nil &&
            view?.selectedCategoryString != nil {
            print("зашли")
            switch view?.kindOfTracker {
            case .unregularEvent:
                print("case unregular")
                view?.unlockCreateButton()
            case .habit:
                view?.selectedScheduleString != nil ? view?.unlockCreateButton() : view?.lockCreateButton()
            default:
                print("case default")
                view?.lockCreateButton()
            }
        } else {
            print("case else ")
            view?.lockCreateButton()
        }
    }
}
