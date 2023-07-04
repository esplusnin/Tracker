//
//  NewTrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import UIKit

protocol NewTrackerViewControllerProtocol: AnyObject {
    var kindOfTracker: KindOfTrackers? { get }
    func bind()
    func reloadTableView()
}
