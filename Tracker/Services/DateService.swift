//
//  DateService.swift
//  Tracker
//
//  Created by Евгений on 26.05.2023.
//

import UIKit

final class DateService {
    
    let calendar = Calendar.current
    
    func getNumberOfCurrentDate(_ date: Date?) -> Int {
        guard let date = date else { return 8 }
        
        let weekDayNumber = calendar.component(.weekday, from: date)
        
        return weekDayNumber
    }
    
    func getCurrentWeekDayStringFromDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let weekDay = calendar.component(.weekday, from: date)
        
        switch weekDay {
        case 1:
            return "Воскресенье"
        case 2:
            return "Понедельник"
        case 3:
            return "Вторник"
        case 4:
            return "Среда"
        case 5:
            return "Четверг"
        case 6:
            return "Пятница"
        case 7:
            return "Суббота"
        default:
            return ""
        }
    }
}
