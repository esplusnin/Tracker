//
//  TrackersViewPresenter.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

final class TrackersPresenter: TrackersViewPresenterProtocol {
    
    weak var view: TrackersViewControllerProtocol?
    
    var currentDate: Date?
    
    private let dataProviderService = DataProviderService.instance
    
    // Operates with DataProviderSevice:
    func getVisibleCategoryFromProvider() -> [TrackerCategory] {
        dataProviderService.getVisiblieCategories()
    }
    
    func setVisibleCategory(_ categories: [TrackerCategory]) {
        dataProviderService.setVisibleCategory(categories)
    }
    
    func getTrackerRecords() -> [TrackerRecord] {
        dataProviderService.getTrackerRecords()
    }
    
    func setTrackerRecords(_ records: [TrackerRecord]) {
        dataProviderService.setTrackerRecords(records)
    }
    
    func changeStatusTrackerRecord(model: TrackerRecord, isAddDay: Bool) {
        dataProviderService.changeStatusTrackerRecord(model: model, isAddDay: isAddDay)
    }
    
    func editTracker(id: UUID) {
        dataProviderService.editTrackerFromStore(id: id)
    }
    
    func deleteTracker(id: UUID) {
        dataProviderService.deleteTrackerFromStore(id: id)
    }
    
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
    
    func setupParticularCell(model: Tracker,
                             cell: TrackerCell,
                             _ indexPath: IndexPath,
                             id: UUID) {
        let cellButtonString = setCellButtonIfTrackerWasCompletedToday(id: id)
        
        cell.cellView.backgroundColor = model.color
        cell.trackerLabel.text = model.name
        cell.emojiLabel.text = model.emoji
        cell.completeTrackerDayButton.backgroundColor = model.color
        cell.numberOfDaysLabel.text = updateCellDayLabel(at: indexPath)
        cell.completeTrackerDayButton.setTitle(cellButtonString, for: .normal)
        
        if cellButtonString == "+" {
            cell.completeTrackerDayButton.alpha = 1
        } else {
            cell.completeTrackerDayButton.alpha = 0.5
        }
    }
    
    func setCellButtonIfTrackerWasCompletedToday(id: UUID) -> String {
        var string = "+"
        let completedTrackers = getTrackerRecords()
        
        completedTrackers.forEach({ trackers in
            if trackers.id == id && currentDate == trackers.date {
                string = "✓"
            }
        })
        
        return string
    }
    
    func countAmountOfCompleteDays(id: UUID) -> Int {
        var counter = 0
        let completedTrackers = getTrackerRecords()
        
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
    
    func updateCellDayLabel(at indexPath: IndexPath) -> String {
        let id = getVisibleCategoryFromProvider()[indexPath.section].trackerDictionary[indexPath.row].id
        let string = updateNumberOfCompletedDaysLabel(countAmountOfCompleteDays(id: id))
        
        return string
    }
    
    func showNewTrackersAfterChangeDate() {
        dataProviderService.inizializeVisibleCategories()
        guard let date = currentDate else { return }
        
        let visibleTracker = getVisibleCategoryFromProvider()
        var newArray: [TrackerCategory] = []
        
        for category in visibleTracker {
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
        
        setVisibleCategory(newArray)
        view?.reloadCOll()
    }
}
