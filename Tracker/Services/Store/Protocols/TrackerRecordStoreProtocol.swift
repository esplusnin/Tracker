//
//  TrackerRecordStoreProtocol.swift
//  Tracker
//
//  Created by Евгений on 07.06.2023.
//

import Foundation

protocol TrackerRecordStoreProtocol {
    func getTrackerRecords() -> [TrackerRecord]
    func deleteRecord(tracker: TrackerRecord)
    func editRecord(_ trackerID: UUID, newRecordValues: Int)
}
