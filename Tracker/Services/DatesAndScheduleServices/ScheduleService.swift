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
        case L10n.Schedule.sunday:
            return 1
        case L10n.Schedule.monday:
            return 2
        case L10n.Schedule.tuesday:
            return 3
        case L10n.Schedule.wednesday:
            return 4
        case L10n.Schedule.thursday:
            return 5
        case L10n.Schedule.friday:
            return 6
        case L10n.Schedule.saturday:
            return 7
        default:
            return 0
        }
    }
    
    private func getShortNameWeekDayFromNumber(_ number: Int) -> String {
        switch number {
        case 1:
            return L10n.Schedule.Sunday.short
        case 2:
            return L10n.Schedule.Monday.short
        case 3:
            return L10n.Schedule.Tuesday.short
        case 4:
            return L10n.Schedule.Wednesday.short
        case 5:
            return L10n.Schedule.Thursday.short
        case 6:
            return L10n.Schedule.Friday.short
        case 7:
            return L10n.Schedule.Saturday.short
        default:
            return ""
        }
    }
}
