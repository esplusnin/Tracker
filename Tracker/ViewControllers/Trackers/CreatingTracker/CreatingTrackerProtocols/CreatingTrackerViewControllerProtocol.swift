//
//  CreatingTrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 26.05.2023.
//

import Foundation

protocol CreatingTrackerViewControllerProtocol: AnyObject {
    var trackerPresenter: TrackersViewPresenterProtocol? { get }
    var trackerViewController: TrackersViewControllerProtocol? { get }
    func backToTrackerViewController()
}
