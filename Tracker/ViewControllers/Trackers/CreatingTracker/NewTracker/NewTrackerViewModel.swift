//
//  NewTrackerViewModel.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import UIKit

final class NewTrackerViewModel: NewTrackerViewModelProtocol {
    
    weak var view: NewTrackerViewControllerProtocol?
    
    private let dataProviderService = DataProviderService.instance
    
    let buttonsTitleForTableView = [LocalizableConstants.NewTrackerVC.tableViewCategory, LocalizableConstants.NewTrackerVC.tableViewSchedule]
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    var colorSectionArray: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4,
        .colorSelection5, .colorSelection6, .colorSelection7, .colorSelection8,
        .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16,
        .colorSelection17, .colorSelection18,
    ]
    
    @Observable
    private(set) var isReadyToCreateNewTracker = false
    @Observable
    private(set) var isTrackerDidCreate = false
    
    init() {
        dataProviderService.bindNewTrackerViewModel(controller: self)
    }
    
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
    
    // MARK: Setting Tracker info:
    func setTrackerName(name: String) {
        dataProviderService.trackerName = name == "" ? nil : name
    }
    
    func clearTrackerName() {
        dataProviderService.trackerName = nil
    }
    
    func setTrackerEmoji(emoji: String) {
        dataProviderService.trackerEmoji = emoji
    }
    
    func setTrackerColor(color: UIColor) {
        dataProviderService.trackerColor = color
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
    
    func resetTrackerInfoAfterCreate() {
        dataProviderService.resetNewTrackerInfo()
    }
    
    // MARK: Getting Tracker info:
    func getSelectedCategoryName() -> String? {
        dataProviderService.selectedCategoryString
    }
    
    func getSelectedScheduleString() -> String? {
        dataProviderService.selectedScheduleString
    }
    
    // MARK: Rule wrapped property:
    func trackerDidCreate() {
        isTrackerDidCreate = true
    }
    
    func changeStatusToCreateTracker() {
        isReadyToCreateNewTracker = true
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
}
