//
//  Schedule.swift
//  Tracker
//
//  Created by Евгений on 26.05.2023.
//

import Foundation

final class ScheduleService {
    
    func getScheduleString(_ schedule: [Int]) -> String {
        let scheduleArray = Array(Set(schedule)).sorted()
        var string = ""
        
        for number in scheduleArray {
            let shortName = getShortNameWeekDayFromNumber(number)
            string += "\(shortName) ,"
        }
        
        return String(string.dropLast())
    }
    
    func addWeekDayToSchedule(dayName: String) -> Int {
        switch dayName {
        case LocalizableConstants.ScheduleVC.sunday:
            return 1
        case LocalizableConstants.ScheduleVC.monday:
            return 2
        case LocalizableConstants.ScheduleVC.tuesday:
            return 3
        case LocalizableConstants.ScheduleVC.wednesday:
            return 4
        case LocalizableConstants.ScheduleVC.thursday:
            return 5
        case LocalizableConstants.ScheduleVC.friday:
            return 6
        case LocalizableConstants.ScheduleVC.saturday:
            return 7
        default:
            return 0
        }
    }
    
    private func getShortNameWeekDayFromNumber(_ number: Int) -> String {
        switch number {
        case 1:
            return LocalizableConstants.ScheduleVC.sundayShort
        case 2:
            return LocalizableConstants.ScheduleVC.mondayShort
        case 3:
            return LocalizableConstants.ScheduleVC.tuesdayShort
        case 4:
            return LocalizableConstants.ScheduleVC.wednesdayShort
        case 5:
            return LocalizableConstants.ScheduleVC.thursdayShort
        case 6:
            return LocalizableConstants.ScheduleVC.fridayShort
        case 7:
            return LocalizableConstants.ScheduleVC.saturdayShort
        default:
            return ""
        }
    }
}
