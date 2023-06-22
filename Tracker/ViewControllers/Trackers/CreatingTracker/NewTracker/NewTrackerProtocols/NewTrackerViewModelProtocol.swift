//
//  NewTrackerViewModelProtocol.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import Foundation

protocol NewTrackerViewModelProtocol: AnyObject {
    var view: NewTrackerViewControllerProtocol? { get set }
    var buttonsTitleForTableView: [String] { get }
    func createNewTracker()
    func trackerDidCreate()
    func setTrackerName(name: String)
    func clearTrackerName()
    func resetTrackerInfoAfterDeselect(section: Int)
    func resetTrackerInfoAfterCreate()
    func isControllerReadyToCreateNewTracker()
    func changeStatusToCreateTracker()
}
