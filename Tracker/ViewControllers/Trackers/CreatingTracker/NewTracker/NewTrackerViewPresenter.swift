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
    
    func calculationSizeForItemAtCollectionView(section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: 32, height: 38)
        case 1:
            return CGSize(width: 46, height: 46)
        default:
            return CGSize(width: 32, height: 38)
        }
    }
    
    func calculationMinimumInteritemSpacingForSectionAt(section: Int) -> CGFloat {
        switch section {
        case 0:
            return 25
        case 1:
            return 12
        default:
            return 25
        }
    }
    
    func calculationMinimumLineSpacingForSectionAt(section: Int) -> CGFloat {
        switch section {
        case 0:
            return 14
        case 1:
            return 6
        default:
            return 14
        }
    }
}
