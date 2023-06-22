//
//  NewTrackerViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import UIKit

protocol NewTrackerViewControllerProtocol: AnyObject {
    var dataProviderService: DataProviderService { get set }
    var kindOfTracker: KindOfTrackers? { get }
    func bind()
    func reloadTableView()
    func unlockCreateButton()
    func lockCreateButton()
}
