//
//  TrackerStoreProtocol.swift
//  Tracker
//
//  Created by Евгений on 06.06.2023.
//

import Foundation

protocol TrackerStoreProtocol: AnyObject {
    func fetchTrackers() -> [TrackerCategory]
    func addTracker(model: Tracker)
    func getTracker(categoryName: String, searchedindex: Int) -> Tracker
    func editTracker(newModel: Tracker)
    func updateController()
    func pinTracker(_ trackerID: UUID)
    func unpinTracker(_ trackerID: UUID)
    func deleteTracker(id: UUID)
}
