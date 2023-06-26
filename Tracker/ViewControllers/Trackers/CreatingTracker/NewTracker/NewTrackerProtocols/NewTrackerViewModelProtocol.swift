//
//  NewTrackerViewModelProtocol.swift
//  Tracker
//
//  Created by Евгений on 20.06.2023.
//

import UIKit

protocol NewTrackerViewModelProtocol: AnyObject {
    var view: NewTrackerViewControllerProtocol? { get set }
    var emojiArray: [String] { get }
    var colorSectionArray: [UIColor] { get }
    var buttonsTitleForTableView: [String] { get }
    func createNewTracker()
    func trackerDidCreate()
    func setTrackerName(name: String)
    func clearTrackerName()
    func resetTrackerInfoAfterDeselect(section: Int)
    func resetTrackerInfoAfterCreate()
    func isControllerReadyToCreateNewTracker()
    func changeStatusToCreateTracker()
    func setTrackerEmoji(emoji: String)
    func setTrackerColor(color: UIColor)
    func getSelectedCategoryName() -> String?
    func getSelectedScheduleString() -> String?
}
