//
//  TrackerStoreProtocol.swift
//  Tracker
//
//  Created by Евгений on 06.06.2023.
//

import Foundation

protocol TrackerStoreProtocol: AnyObject {
    func setPredicate(with word: String)
    func addTracker(model: Tracker)
    func getTracker(categoryName: String, searchedindex: Int) -> Tracker
}
