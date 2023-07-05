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
    
    func getRandomDate(times: Int) -> [Date] {
        var dateArray:[Date] = []
        
        if times > 0 {
            for _ in 1...times {
                let year = Int.random(in: 1...9999)
                let month = Int.random(in: 1...12)
                let day = Int.random(in: 1...31)
                let hour = Int.random(in: 0...23)
                let minute = Int.random(in: 0...59)
                
                var dateComponents = DateComponents()
                dateComponents.year = year
                dateComponents.month = month
                dateComponents.day = day
                dateComponents.hour = hour
                dateComponents.minute = minute
                
                if let date = calendar.date(from: dateComponents) {
                    dateArray.append(date)
                }
            }
        } else {
            return []
        }
        
        return dateArray
    }
}
