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
    func checkCurrentDateIsFuture() -> Bool
    func searchTrackerByName(categories: [TrackerCategory], filledName: String) -> [TrackerCategory]
    func setupParticularCell(model: Tracker,
                             cell: TrackerCell,
                             _ indexPath: IndexPath,
                             id: UUID) 
//    func updateCompletedTrackersArray(isAddDay: Bool,
//                                      date: Date,
//                                      indexPath: IndexPath) -> [TrackerRecord]
    func setCellButtonIfTrackerWasCompletedToday(id: UUID) -> String
    func countAmountOfCompleteDays(id: UUID) -> Int
    func updateNumberOfCompletedDaysLabel(_ number: Int) -> String
    func updateCellDayLabel(at indexPath: IndexPath) -> String
    func showNewTrackersAfterChangeDate()
}
