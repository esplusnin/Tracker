//
//  TrackersViewPresenterProtocol.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

protocol TrackersViewPresenterProtocol: AnyObject {
    var view: TrackersViewControllerProtocol? { get set }
    var currentDate: Date? { get set }
    func getVisibleCategoryFromProvider() -> [TrackerCategory]
    func setVisibleCategory(_ categories: [TrackerCategory])
    func getTrackerRecords() -> [TrackerRecord]
    func setTrackerRecords(_ records: [TrackerRecord])
    func changeStatusTrackerRecord(model: TrackerRecord, isAddDay: Bool)
    func editTracker(id: UUID)
    func deleteTracker(id: UUID)
    func checkCurrentDateIsFuture() -> Bool
    func searchTrackerByName(categories: [TrackerCategory], filledName: String) -> [TrackerCategory]
    func setupParticularCell(model: Tracker,
                             cell: TrackerCell,
                             _ indexPath: IndexPath,
                             id: UUID) 
    func setCellButtonIfTrackerWasCompletedToday(id: UUID) -> String
    func countAmountOfCompleteDays(id: UUID) -> Int
    func updateNumberOfCompletedDaysLabel(_ number: Int) -> String
    func updateCellDayLabel(at indexPath: IndexPath) -> String
    func showNewTrackersAfterChangeDate()
}
