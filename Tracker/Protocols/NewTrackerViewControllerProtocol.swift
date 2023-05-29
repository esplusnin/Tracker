//
//  NewTrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import Foundation

protocol NewTrackerViewControllerProtocol: AnyObject {
    var selectedCategory: String? { get set }
    var selectedSchedule: String? { get set }
    func reloadTableView()
}
