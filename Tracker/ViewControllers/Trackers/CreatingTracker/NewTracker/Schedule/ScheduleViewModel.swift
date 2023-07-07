//
//  ScheduleViewModel.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import Foundation

final class ScheduleViewModel: ScheduleViewModelProtocol {
    
    private let dataProviderService = DataProviderService.instance
    private let scheduleService = ScheduleService()
    private let analyticsService = AnalyticsService.instance
    
    @Observable
    private(set) var isReadyToCloseScheduleVC = false
    @Observable
    private(set) var isReadyToUnlockCreateButton = false
    private(set) var schedule: [Int] = []
    private(set) var daysArray = [LocalizableConstants.ScheduleVC.monday, LocalizableConstants.ScheduleVC.tuesday, LocalizableConstants.ScheduleVC.wednesday, LocalizableConstants.ScheduleVC.thursday, LocalizableConstants.ScheduleVC.friday, LocalizableConstants.ScheduleVC.saturday, LocalizableConstants.ScheduleVC.sunday]
    
    init() {
        dataProviderService.bindScheduleViewModel(controller: self)
    }
    
    func addDayToSchedule(day: Int) {
        schedule.append(day)
        isScheduleEmpty()
    }
    
    func removeAddFromSchedule(index: Int) {
        schedule.remove(at: index)
        isScheduleEmpty()
    }
    
    func setSchedule() {
        let string = schedule.count == 7 ? LocalizableConstants.ScheduleVC.everyDay : scheduleService.getScheduleString(schedule)
        
        if string == LocalizableConstants.ScheduleVC.everyDay {
            analyticsService.sentEvent(typeOfEvent: .click, screen: .scheduleVC, item: .everyDay)
        } else {
            analyticsService.sentEvent(typeOfEvent: .click, screen: .scheduleVC, item: .notEveryDay)
        }
        
        dataProviderService.selectedScheduleString = string
        dataProviderService.trackerSchedule = schedule
        
        schedule = []
    }
    
    func changeStatusToCloseSchedule() {
        isReadyToCloseScheduleVC = true
    }
    
    func returnNumberOfDay(from index: IndexPath) -> Int {
        scheduleService.addWeekDayToSchedule(dayName: daysArray[index.row])
    }
    
    func isCurrentDayExistInSchedule(day: Int) -> Bool {
        dataProviderService.isCurrentDayFromScheduleExist(day) ? true : false
    }
    
    private func isScheduleEmpty() {
        isReadyToUnlockCreateButton = schedule.count == 0 ? false : true
    }
}
