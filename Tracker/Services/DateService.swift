//
//  DateService.swift
//  Tracker
//
//  Created by Евгений on 26.05.2023.
//

import UIKit

final class DateService {
    
    private let calendar = Calendar.current
    
    func convertDateWithoutTimes(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        return calendar.date(from: components) ?? Date()
    }
    
    func getNumberOfCurrentDate(_ date: Date?) -> Int {
        guard let date = date else { return 8 }
        
        let weekDayNumber = calendar.component(.weekday, from: date)
        
        return weekDayNumber
    }
}
