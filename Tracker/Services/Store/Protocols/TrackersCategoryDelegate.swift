//
//  TrackersCategoryDelegate.swift
//  Tracker
//
//  Created by Евгений on 09.06.2023.
//

import Foundation

protocol TrackersCategoryDelegate: AnyObject {
    func didUpdate(updates: CollectionStoreUpdates)
}
