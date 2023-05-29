//
//  TrackersViewPresenterProtocol.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

protocol TrackersViewPresenterProtocol: AnyObject {
    var categories: [TrackerCategory]? { get set }
    var emojiArray: [String] { get }
    var currentDate: Date? { get set }
}
