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
        case LocalizableConstants.Schedule.sunday:
            return 1
        case LocalizableConstants.Schedule.monday:
            return 2
        case LocalizableConstants.Schedule.tuesday:
            return 3
        case LocalizableConstants.Schedule.wednesday:
            return 4
        case LocalizableConstants.Schedule.thursday:
            return 5
        case LocalizableConstants.Schedule.friday:
            return 6
        case LocalizableConstants.Schedule.saturday:
            return 7
        default:
            return 0
        }
    }
    
    private func getShortNameWeekDayFromNumber(_ number: Int) -> String {
        switch number {
        case 1:
            return LocalizableConstants.Schedule.sundayShort
        case 2:
            return LocalizableConstants.Schedule.mondayShort
        case 3:
            return LocalizableConstants.Schedule.tuesdayShort
        case 4:
            return LocalizableConstants.Schedule.wednesdayShort
        case 5:
            return LocalizableConstants.Schedule.thursdayShort
        case 6:
            return LocalizableConstants.Schedule.fridayShort
        case 7:
            return LocalizableConstants.Schedule.saturdayShort
        default:
            return ""
        }
    }
}
