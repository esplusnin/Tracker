//
//  NewTrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import Foundation

protocol NewTrackerViewControllerProtocol: AnyObject {
    var selectedCategoryString: String? { get set }
    var selectedScheduleString: String? { get set }
    var trackerSchedule: [Int]? { get set }
    func reloadTableView()
}
