//
//  TrackersViewPresenterProtocol.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

protocol TrackersViewPresenterProtocol: AnyObject {
    var view: TrackersViewControllerProtocol? { get }
//    var categories: [TrackerCategory]? { get set }
//    var visibleCategories: [TrackerCategory]? { get }
//    var completedTrackers: [TrackerRecord]? { get set }
    var emojiArray: [String] { get }
    var currentDate: Date? { get set }
    func checkCurrentDateIsFuture() -> Bool
    func searchTrackerByName(categories: [TrackerCategory], filledName: String) -> [TrackerCategory]
    func setupParticularCell(storage: TrackerStorageService, cell: TrackerCell,_ section: Int,_ row: Int)
    func updateCompletedTrackersArray(storage: TrackerStorageService,
                                      isAddDay: Bool,
                                      date: Date,
                                      _ section: Int,
                                      _ row: Int) -> [TrackerRecord]
    func setCellButtonIfTrackerWasCompletedToday(_ completedTrackers: [TrackerRecord], _ id: UUID) -> String
    func countAmountOfCompleteDays(_ completedTrackers: [TrackerRecord], id: UUID) -> Int
    func updateNumberOfCompletedDaysLabel(_ number: Int) -> String
    func updateCellDayLabel(_ storage: TrackerStorageService, _ section: Int, row: Int) -> String
    func showNewTrackersAfterChanges(_ totalTrackers: [TrackerCategory]) -> [TrackerCategory]
}
