//
//  TrackersViewPresenter.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

final class TrackersViewPresenter: TrackersViewPresenterProtocol {
    
    var categories: [TrackerCategory]? = [
        TrackerCategory(name: "Важное", trackerDictionary: [Tracker(id: UUID(),
                                                                    name: "Сделать проект как красавчик",
                                                                    color: .colorSelection1,
                                                                    emoji: "🐶",
                                                                    schedule: [1,2,3,4,5,6,7])]),
        TrackerCategory(name: "Английский", trackerDictionary: [Tracker(id: UUID(),
                                                                        name: "Домашка + слова",
                                                                        color: .colorSelection10,
                                                                        emoji: "🏝",
                                                                        schedule: [1,2,3,4,5,6,7])])
    ]
    var visibleCategories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?
    var currentDate: Date?
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    func setupParticularCell(cell: TrackerCell,_ section: Int,_ row: Int) {
        guard let currentTracker = visibleCategories?[section].trackerDictionary[row],
              let id = categories?[section].trackerDictionary[row].id else { return }
        
        let cellButtonString = setCellButtonIfTrackerWasCompletedToday(id)
        
        cell.cellView.backgroundColor = currentTracker.color
        cell.trackerLabel.text = currentTracker.name
        cell.emojiLabel.text = currentTracker.emoji
        cell.completeTrackerDayButton.backgroundColor = currentTracker.color
        cell.numberOfDaysLabel.text = updateCellDayLabel(section, row: row)
        cell.completeTrackerDayButton.setTitle(cellButtonString, for: .normal)
        
        if cellButtonString == "+" {
            cell.completeTrackerDayButton.alpha = 1
        } else {
            cell.completeTrackerDayButton.alpha = 0.5
        }
    }
    
    func updateCompletedTrackersArray(isAddDay: Bool, date: Date,_ section: Int,_ row: Int) {
        guard let id = visibleCategories?[section].trackerDictionary[row].id else { return }
        
        var newTrackerRecordArray: [TrackerRecord] = []
        
        completedTrackers?.forEach({ trackerRecord in
            newTrackerRecordArray.append(trackerRecord)
        })
        
        if isAddDay {
            newTrackerRecordArray.append(TrackerRecord(
                id: id,
                date: date))
        } else {
            for trackerRecord in newTrackerRecordArray {
                if trackerRecord.date == currentDate {
                newTrackerRecordArray.remove(at: row)
                }
            }
        }
        
        completedTrackers = newTrackerRecordArray
    }
    
    func setCellButtonIfTrackerWasCompletedToday(_ id: UUID) -> String {
        var string = "+"
        completedTrackers?.forEach({ trackers in
            if trackers.id == id && currentDate == trackers.date {
                string = "✓"
            }
        })
        
        return string
    }
    
    func countAmountOfCompleteDays(id: UUID) -> Int {
        var counter = 0
        
        completedTrackers?.forEach({ trackerRecord in
            if trackerRecord.id == id {
                counter += 1
            }
        })
        print(counter)
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
    
    func updateCellDayLabel(_ section: Int, row: Int) -> String {
        guard let category = categories else { return "" }
        
        let id = category[section].trackerDictionary[row].id
        let string = updateNumberOfCompletedDaysLabel(countAmountOfCompleteDays(id: id))
        
        return string
    }
    
    func showNewTrackersAfterChanges() {
        guard let categories = categories,
              let date = currentDate else { return }
        
        var newArray: [TrackerCategory] = []
        
        for category in categories {
            var newCategory = TrackerCategory(name: category.name, trackerDictionary: [])
            
            
            for tracker in category.trackerDictionary {
                guard let schedule = tracker.schedule else { return }
                let trackerDate = DateService().getNumberOfCurrentDate(date)
                
                if schedule.contains(trackerDate) {
                    newCategory.trackerDictionary.append(tracker)
                }
            }
            newArray.append(newCategory)
        }
        visibleCategories = newArray
    }
}
