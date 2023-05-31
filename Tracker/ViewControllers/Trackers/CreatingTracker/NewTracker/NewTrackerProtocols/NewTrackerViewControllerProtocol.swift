//
//  NewTrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import UIKit

protocol NewTrackerViewControllerProtocol: AnyObject {
    var presenter: NewTrackerViewPresenterProtocol? { get set }
    var storage: TrackerStorageService { get set }
    var kindOfTracker: KindOfTrackers? { get }
    var selectedCategoryString: String? { get set }
    var selectedScheduleString: String? { get set }
    var trackerName: String? { get set }
    var trackerColor: UIColor? { get set }
    var trackerEmoji: String? { get set }
    var trackerSchedule: [Int]? { get set }
    func reloadTableView()
    func unlockCreateButton()
    func lockCreateButton()
}
