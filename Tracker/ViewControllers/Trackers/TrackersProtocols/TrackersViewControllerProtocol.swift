//
//  TrackersViewControllerProtocol.swift
//  Tracker
//
//  Created by Евгений on 21.05.2023.
//

import Foundation

protocol TrackersViewControllerProtocol: AnyObject {
    func resetTextField()
    func reloadCollectionView()
    func changeStatusForFilterButton(isHide: Bool)
}

