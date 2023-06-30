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
    
    @ScheduleObservable
    private(set) var isReadyToCloseSchedule = false
    private(set) var schedule: [Int] = []
    private(set) var daysArray = [LocalizableConstants.Schedule.monday, LocalizableConstants.Schedule.tuesday, LocalizableConstants.Schedule.wednesday, LocalizableConstants.Schedule.thursday, LocalizableConstants.Schedule.friday, LocalizableConstants.Schedule.saturday, LocalizableConstants.Schedule.sunday]
    
    init() {
        dataProviderService.bindScheduleViewModel(controller: self)
    }
    
    func addDayToSchedule(day: Int) {
        schedule.append(day)
    }
    
    func removeAddFromSchedule(index: Int) {
        schedule.remove(at: index)
    }
    
    func setSchedule() {
        let string = schedule.count == 7 ? LocalizableConstants.Schedule.everyDay : scheduleService.getScheduleString(schedule)
        
        dataProviderService.selectedScheduleString = string
        dataProviderService.trackerSchedule = schedule
        
        schedule = []
    }
    
    func changeStatusToCloseSchedule() {
        isReadyToCloseSchedule = true
    }
    
    func returnNumberOfDay(from index: IndexPath) -> Int {
        scheduleService.addWeekDayToSchedule(dayName: daysArray[index.row])
    }
    
    func isCurrentDayExistInSchedule(day: Int) -> Bool {
        dataProviderService.isCurrentDayFromScheduleExist(day) ? true : false
    }
}
