//
//  SchedulePresenterProtocol.swift
//  Tracker
//
//  Created by Евгений on 31.05.2023.
//

import Foundation

protocol SchedulePresenterProtocol: AnyObject {
    var schedule: [Int] { get set }
    var daysArray: [String] { get }
}
