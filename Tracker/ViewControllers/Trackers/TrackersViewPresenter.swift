//
//  TrackersViewPresenter.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

final class TrackersViewPresenter {
    
    var categories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?
    var currentDate: Date?
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
}
