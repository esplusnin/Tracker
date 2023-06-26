//
//  ScheduleViewModelProtocol.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import Foundation

protocol ScheduleViewModelProtocol: AnyObject {
    func addDayToSchedule(day: Int)
    func removeAddFromSchedule(index: Int)
    func setSchedule()
    func changeStatusToCloseSchedule()
    func returnNumberOfDay(from index: IndexPath) -> Int
    func isCurrentDayExistInSchedule(day: Int) -> Bool
}
