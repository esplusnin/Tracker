//
//  AdditionalUserDefaultTools.swift
//  Tracker
//
//  Created by Евгений on 10.07.2023.
//

import Foundation

final class StatisticsServiceHelper {
    
    private let userDefaults = UserDefaults.standard
    private let dataProviderService = DataProviderService.instance
    
    private var perfectDays: [Date] {
        get {
            return userDefaults.object(forKey: "perfectDays") as? [Date] ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "perfectDays")
            countBestSeries()
        }
    }
    
    private var bestSeries: Int {
        get {
            return userDefaults.integer(forKey: "bestSeries")
        }
        set {
            userDefaults.set(newValue, forKey: "bestSeries")
            dataProviderService.setRecordsToStatisticsService()
        }
    }
    
    func setNewPerfectDaysValue(date: Date) {
        var oldValues = perfectDays
        
        oldValues.append(DateService().convertDateWithoutTimes(date: date))
        
        perfectDays = oldValues
    }
    
    func removePerfectDays(date: Date) {
        var oldValue = perfectDays
        guard let index = oldValue.firstIndex(where: { $0 == date }) else { return }
        
        oldValue.remove(at: index)
        perfectDays = oldValue
    }
    
    func removeAllStatistics() {
        if perfectDays != [] && bestSeries != 0 {
            perfectDays = []
            bestSeries = 0
        }
    }
    
    func getCountOfPerfectDays() -> Int {
        perfectDays.count
    }
    
    func getBestSeries() -> Int {
        bestSeries
    }
    
    private func countBestSeries() {
        let calendar = Calendar.current
        
        let sortedDates = perfectDays.sorted()
        
        if sortedDates.count != 0 {
            var longestSequence: [Date] = []
            var currentSequence: [Date] = [sortedDates[0]]
            
            for i in 1..<sortedDates.count {
                let previousDate = calendar.date(byAdding: .day, value: 1, to: sortedDates[i - 1])!
                
                if calendar.isDate(sortedDates[i], inSameDayAs: previousDate) {
                    currentSequence.append(sortedDates[i])
                } else {
                    if currentSequence.count > longestSequence.count {
                        longestSequence = currentSequence
                    }
                    currentSequence = [sortedDates[i]]
                }
            }
            
            if currentSequence.count > longestSequence.count {
                longestSequence = currentSequence
            }
            
            bestSeries = longestSequence.count
        } else {
            bestSeries = 0
        }
    }
}
