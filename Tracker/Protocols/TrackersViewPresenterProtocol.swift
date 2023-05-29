//
//  TrackersViewPresenterProtocol.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

protocol TrackersViewPresenterProtocol: AnyObject {
    var categories: [TrackerCategory]? { get set }
    var visibleCategories: [TrackerCategory]? { get }
    var completedTrackers: [TrackerRecord]? { get set }
    var emojiArray: [String] { get }
    var currentDate: Date? { get set }
    func setupParticularCell(cell: TrackerCell,_ section: Int,_ row: Int)
    func updateCompletedTrackersArray(isAddDay: Bool, date: Date,_ section: Int,_ row: Int)
    func setCellButtonIfTrackerWasCompletedToday(_ id: UUID) -> String
    func countAmountOfCompleteDays(id: UUID) -> Int
    func updateNumberOfCompletedDaysLabel(_ number: Int) -> String
    func updateCellDayLabel(_ section: Int, row: Int) -> String
    func showNewTrackersAfterChanges()
}
