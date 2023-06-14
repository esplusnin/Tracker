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
    
    weak var view: NewTrackerViewControllerProtocol?
    
    private let dataProviderService = DataProviderService.instance
    
    let buttonsTitleForTableView = ["Категория", "Расписание"]
        
    func createNewTracker() {
        guard let trackerName = dataProviderService.trackerName,
              let trackerColor = dataProviderService.trackerColor,
              let trackerEmoji = dataProviderService.trackerEmoji else { return }
        
        let tracker = Tracker(id: UUID(),
                              name: trackerName,
                              color: trackerColor,
                              emoji: trackerEmoji,
                              schedule: dataProviderService.trackerSchedule ?? [1,2,3,4,5,6,7])
        print(dataProviderService.trackerSchedule)
        dataProviderService.addTrackerToStore(model: tracker)
    }
    
    func resetTrackerInfoAfterDeselect(section: Int) {
        switch section {
        case 0:
            dataProviderService.trackerEmoji = nil
        case 1:
            dataProviderService.trackerColor = nil
        default:
            return
        }
    }
    
    @objc func checkCreateButtonToUnclock() {
        if dataProviderService.trackerName != nil &&
            dataProviderService.trackerColor != nil &&
            dataProviderService.trackerEmoji != nil &&
            dataProviderService.selectedCategoryString != nil {
            switch view?.kindOfTracker {
            case .unregularEvent:
                view?.unlockCreateButton()
            case .habit:
                dataProviderService.selectedScheduleString != nil ? view?.unlockCreateButton() : view?.lockCreateButton()
            default:
                view?.lockCreateButton()
            }
        } else {
            view?.lockCreateButton()
        }
    }
}
