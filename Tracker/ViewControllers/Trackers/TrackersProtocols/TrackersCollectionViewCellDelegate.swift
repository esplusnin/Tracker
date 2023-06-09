//
//  TrackerViewControllerDelegate.swift
//  Tracker
//
//  Created by Евгений on 29.05.2023.
//

import Foundation

protocol TrackersCollectionViewCellDelegate: AnyObject {
    func addCurrentTrackerToCompletedThisDate(_ cell: TrackerCell, isAddDay: Bool)
    func editTracker(from cell: TrackerCell)
    func deleteTracker(from cell: TrackerCell)
}
