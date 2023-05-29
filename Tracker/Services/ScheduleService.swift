//
//  Schedule.swift
//  Tracker
//
//  Created by Евгений on 26.05.2023.
//

import Foundation

enum WeekDays: String {
    case monday = "Понедельник"
    case tuesday = "Вторник"
    case wednesday = "Среда"
    case thoursday  = "Четверг"
    case friday = "Пятница"
    case saturday = "Суббота"
    case sunday = "Воскресенье"
}

final class ScheduleService {
    var schedule: [String: Bool] = [
        "Понедельник": false,
        "Вторник": false,
        "Среда": false,
        "Четверг": false,
        "Пятница": false,
        "Суббота": false,
        "Воскресенье": false,
    ]
    
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
        case "Воскресенье":
            return 1
        case "Понедельник":
            return 2
        case "Вторник":
            return 3
        case "Среда":
            return 4
        case "Четверг":
            return 5
        case "Пятница":
            return 6
        case "Суббота":
            return 7
        default:
            return 0
        }
    }
    
    private func getShortNameWeekDayFromNumber(_ number: Int) -> String {
        switch number {
        case 1:
            return "Вс"
        case 2:
            return "Пн"
        case 3:
            return "Вт"
        case 4:
            return "Ср"
        case 5:
            return "Чт"
        case 6:
            return "Пт"
        case 7:
            return "Сб"
        default:
            return ""
        }
    }
}
