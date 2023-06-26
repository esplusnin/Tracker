//
//  TrackersViewModelProtocol.swift
//  Tracker
//
//  Created by Евгений on 22.06.2023.
//

import Foundation

protocol TrackersViewModelProtocol: AnyObject {
    var additionTrackerInfo: AdditionTrackerInfo? { get }
    var currentDate: Date? { get set }
    func setVisibleTrackersFromProvider()
    func recordDidUpdate()
    func updateVisibleTrackersAfterSearch(filledName: String)
    func fillAdditionalInfo(id: UUID)
    func changeStatusTrackerRecord(model: TrackerRecord, isAddDay: Bool)
}
