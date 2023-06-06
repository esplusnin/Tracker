//
//  TrackersViewPresenterProtocol.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

protocol TrackersViewPresenterProtocol: AnyObject {
    var currentDate: Date? { get set }
    func checkCurrentDateIsFuture() -> Bool
    func searchTrackerByName(categories: [TrackerCategory], filledName: String) -> [TrackerCategory]
    func setupParticularCell(storage: DataProviderService, cell: TrackerCell,_ section: Int,_ row: Int)
    func updateCompletedTrackersArray(storage: DataProviderService,
                                      isAddDay: Bool,
                                      date: Date,
                                      _ section: Int,
                                      _ row: Int) -> [TrackerRecord]
    func setCellButtonIfTrackerWasCompletedToday(_ completedTrackers: [TrackerRecord], _ id: UUID) -> String
    func countAmountOfCompleteDays(_ completedTrackers: [TrackerRecord], id: UUID) -> Int
    func updateNumberOfCompletedDaysLabel(_ number: Int) -> String
    func updateCellDayLabel(_ storage: DataProviderService, _ section: Int, row: Int) -> String
    func showNewTrackersAfterChanges(_ totalTrackers: [TrackerCategory]) -> [TrackerCategory]
}
