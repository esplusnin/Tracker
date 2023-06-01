//
//  TrackerViewControllerDelegate.swift
//  Tracker
//
//  Created by Евгений on 29.05.2023.
//

import Foundation

protocol TrackersViewControllerDelegate: AnyObject {
    func addCurrentTrackerToCompletedThisDate(_ cell: TrackerCell, isAddDay: Bool)
}
