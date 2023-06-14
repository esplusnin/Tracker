//
//  CategoryViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import Foundation

protocol CategoryViewControllerProtocol: AnyObject {
    var newTrackerViewController: NewTrackerViewControllerProtocol? { get }
}
