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
    func resetTrackerInfoAfterDeselect(section: Int)
    func isControllerReadyToCreateNewTracker()
    func changeStatusToCreateTracker()
}
