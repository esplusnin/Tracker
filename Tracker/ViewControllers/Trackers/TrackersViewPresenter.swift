//
//  TrackersViewPresenter.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

final class TrackersViewPresenter: TrackersViewPresenterProtocol {
    
    weak var view: TrackersViewControllerProtocol?
    
    var currentDate: Date?
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    func checkCurrentDateIsFuture() -> Bool {
        guard let currentDate = currentDate else { return false }
        let date = Date()
        
        return date > currentDate ? true : false
    }
    
    func searchTrackerByName(categories: [TrackerCategory], filledName: String) -> [TrackerCategory] {
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
    
    func setupParticularCell(storage: TrackerStorageService, cell: TrackerCell,_ section: Int,_ row: Int) {
        let categories = storage.categories
        let completedTrackers = storage.completedTrackers
        
        guard let currentTracker = categories?[section].trackerDictionary[row],
              let id = categories?[section].trackerDictionary[row].id else { return }
        
        let cellButtonString = setCellButtonIfTrackerWasCompletedToday(completedTrackers ?? [], id)
        
        cell.cellView.backgroundColor = currentTracker.color
        cell.trackerLabel.text = currentTracker.name
        cell.emojiLabel.text = currentTracker.emoji
        cell.completeTrackerDayButton.backgroundColor = currentTracker.color
        cell.numberOfDaysLabel.text = updateCellDayLabel(storage, section, row: row)
        cell.completeTrackerDayButton.setTitle(cellButtonString, for: .normal)
        
        if cellButtonString == "+" {
            cell.completeTrackerDayButton.alpha = 1
        } else {
            cell.completeTrackerDayButton.alpha = 0.5
        }
    }
    
    func updateCompletedTrackersArray(storage: TrackerStorageService,
                                      isAddDay: Bool,
                                      date: Date,
                                      _ section: Int,
                                      _ row: Int) -> [TrackerRecord] {
        guard let id = storage.visibleCategories?[section].trackerDictionary[row].id else { return [] }
        var newTrackerRecordArray: [TrackerRecord] = []
        
        storage.completedTrackers?.forEach({ trackerRecord in
            newTrackerRecordArray.append(trackerRecord)
        })
        
        if isAddDay {
            newTrackerRecordArray.append(TrackerRecord(
                id: id,
                date: date))
        } else {
            for (index, trackerRecord) in newTrackerRecordArray.enumerated() {
                if trackerRecord.date == currentDate &&
                    trackerRecord.id == id {
                    newTrackerRecordArray.remove(at: index)
                }
            }
        }
        
        return newTrackerRecordArray
    }
    
    func setCellButtonIfTrackerWasCompletedToday(_ completedTrackers: [TrackerRecord], _ id: UUID) -> String {
        var string = "+"
        completedTrackers.forEach({ trackers in
            if trackers.id == id && currentDate == trackers.date {
                string = "✓"
            }
        })
        
        return string
    }
    
    func countAmountOfCompleteDays(_ completedTrackers: [TrackerRecord], id: UUID) -> Int {
        var counter = 0
        
        completedTrackers.forEach({ trackerRecord in
            if trackerRecord.id == id {
                counter += 1
            }
        })
        
        return counter
    }
    
    func updateNumberOfCompletedDaysLabel(_ number: Int) -> String {
        var string = "\(number) "
        var array = [number]
        
        switch number {
        case 0:
            string += "Дней"
        case 1:
            string += "День"
        case 2:
            string += "Дня"
        case 3, 4:
            string += "Дня"
        case 5...20:
            string += "Дней"
        case 20...:
            switch array.removeLast() {
            case 1:
                string += "День"
            case 2:
                string += "Дня"
            case 3, 4:
                string += "Дня"
            case 5...9:
                string += "Дней"
            default:
                string += "Дней"
            }
            
        default:
            string = ""
        }
        
        return string
    }
    
    func updateCellDayLabel(_ storage: TrackerStorageService, _ section: Int, row: Int) -> String {
        guard let id = storage.visibleCategories?[section].trackerDictionary[row].id else { return "" }
        let string = updateNumberOfCompletedDaysLabel(countAmountOfCompleteDays(storage.completedTrackers ?? [], id: id))
        
        return string
    }
    
    func showNewTrackersAfterChanges(_ totalTrackers: [TrackerCategory]) -> [TrackerCategory] {
        guard let date = currentDate else { return [] }
        
        var newArray: [TrackerCategory] = []
        
        for category in totalTrackers {
            var newCategory = TrackerCategory(name: category.name, trackerDictionary: [])
            
            
            for tracker in category.trackerDictionary {
                guard let schedule = tracker.schedule else { return [] }
                let trackerDate = DateService().getNumberOfCurrentDate(date)
                
                if schedule.contains(trackerDate) {
                    newCategory.trackerDictionary.append(tracker)
                }
            }
            newArray.append(newCategory)
        }
        
        return newArray
    }
}
