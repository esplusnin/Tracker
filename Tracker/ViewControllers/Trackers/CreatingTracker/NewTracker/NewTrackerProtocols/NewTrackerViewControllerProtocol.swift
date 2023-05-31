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
    func reloadTableView()
    func unlockCreateButton()
    func lockCreateButton()
}
