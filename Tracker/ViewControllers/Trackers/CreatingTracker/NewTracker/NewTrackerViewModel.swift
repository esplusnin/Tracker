//
//  NewTrackerViewModel.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import Foundation

final class NewTrackerViewModel: NewTrackerViewModelProtocol {
    
    weak var view: NewTrackerViewControllerProtocol?
    
    private let dataProviderService = DataProviderService.instance
    
    let buttonsTitleForTableView = ["Категория", "Расписание"]
    
    @NewTrackerObservable
    private(set) var isReadyToCreateNewTracker = false
    @NewTrackerObservable
    private(set) var isTrackerDidCreate = false
    
    
    func createNewTracker() {
        guard let trackerName = dataProviderService.trackerName,
              let trackerColor = dataProviderService.trackerColor,
              let trackerEmoji = dataProviderService.trackerEmoji else { return }
        
        let tracker = Tracker(id: UUID(),
                              name: trackerName,
                              color: trackerColor,
                              emoji: trackerEmoji,
                              schedule: dataProviderService.trackerSchedule ?? [1,2,3,4,5,6,7])

        dataProviderService.addTrackerToStore(model: tracker)
    }
    
    func trackerDidCreate() {
        isTrackerDidCreate = true
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
    
    func isControllerReadyToCreateNewTracker() {
        if dataProviderService.isTrackerParametersWasFilled() {
            switch view?.kindOfTracker {
            case .unregularEvent:
                isReadyToCreateNewTracker = true
            case .habit:
                isReadyToCreateNewTracker = dataProviderService.selectedScheduleString != nil ? true : false
            default:
                isReadyToCreateNewTracker = false
            }
        } else {
            isReadyToCreateNewTracker = false
        }
    }
    
    func changeStatusToCreateTracker() {
        isReadyToCreateNewTracker = true
    }
}
