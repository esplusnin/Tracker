//
//  NewTrackerViewModel.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import UIKit

final class NewTrackerViewModel: NewTrackerViewModelProtocol {
        
    private let dataProviderService = DataProviderService.instance
    
    let buttonsTitleForTableView = [L10n.NewTracker.TableView.category,
                                    L10n.NewTracker.TableView.schedule]
    
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
    private var kindOfTrackers: KindOfTrackers
    
    init(kindOfTrackers: KindOfTrackers) {
        self.kindOfTrackers = kindOfTrackers
        dataProviderService.resetNewTrackerInfo()
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
    func changeStatusToCreateTracker() {
        isReadyToCreateNewTracker = true
    }
    
    func isControllerReadyToCreateNewTracker() {
        if dataProviderService.isTrackerParametersWasFilled() {
            switch kindOfTrackers {
            case .unregularEvent:
                isReadyToCreateNewTracker = true
            case .habit:
                isReadyToCreateNewTracker = dataProviderService.selectedScheduleString != nil ? true : false
            }
        } else {
            isReadyToCreateNewTracker = false
        }
    }
    
    // MARK: Editing tracker info:
    func presetTrackerInfo(trackerInfo: Tracker, additionalTrackerInfo: AdditionTrackerInfo) {
        dataProviderService.trackerName = trackerInfo.name
        dataProviderService.trackerEmoji = trackerInfo.emoji
        dataProviderService.trackerColor = trackerInfo.color
        dataProviderService.trackerSchedule = trackerInfo.schedule
        dataProviderService.selectedCategoryString = additionalTrackerInfo.categoryName
        
        guard let schedule = dataProviderService.trackerSchedule else { return }
        
        let string = schedule.count == 7 ? L10n.Schedule.everyDay : ScheduleService().getScheduleString(schedule)
        
        dataProviderService.selectedScheduleString = string
    }
    
    func editTracker(_ trackerID: UUID) {
        dataProviderService.editTrackerFromStore(trackerID)
    }
    
    func changeRecord(trackerID: UUID, newRecordValues: Int) {
        dataProviderService.setNewValueRecords(trackerID: trackerID, newRecordValues: newRecordValues)
    }
}
