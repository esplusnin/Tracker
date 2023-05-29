//
//  NewTrackerPresenter.swift
//  Tracker
//
//  Created by Евгений on 29.05.2023.
//

import UIKit

protocol NewTrackerViewPresenterProtocol: AnyObject {
    var view: NewTrackerViewControllerProtocol? { get set }
    var buttonsTitleForTableView: [String] { get }
    func createNewTracker() -> [TrackerCategory]
    func checkCreateButtonToUnclock()
    func calculationSizeForItemAtCollectionView(section: Int) -> CGSize
    func calculationMinimumInteritemSpacingForSectionAt(section: Int) -> CGFloat
    func calculationMinimumLineSpacingForSectionAt(section: Int) -> CGFloat
}
