//
//  DateService.swift
//  Tracker
//
//  Created by Евгений on 26.05.2023.
//

import UIKit

final class DateService {
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        return dateFormatter
    }()
    
    let calendar = Calendar.current
    
    func getCurrentWeekDayFromDate(_ date: Date?) -> String {
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
