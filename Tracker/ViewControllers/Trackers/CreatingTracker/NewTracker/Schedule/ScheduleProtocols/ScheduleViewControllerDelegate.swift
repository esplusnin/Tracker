//
//  ScheduleViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 26.05.2023.
//

import Foundation

protocol ScheduleViewControllerDelegate: AnyObject {
    func controlScheduleDay(_ cell: ScheduleCell)
}
