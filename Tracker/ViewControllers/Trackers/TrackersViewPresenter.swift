//
//  TrackersViewPresenter.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

final class TrackersViewPresenter: TrackersViewPresenterProtocol {
    var categories: [TrackerCategory]? = [
        TrackerCategory(name: "Важное", trackerDictionary: [Tracker(id: UUID(),
                                                                    name: "Сделать проект как красавчик",
                                                                    color: .blue,
                                                                    emoji: "🐶",
                                                                    schedule: nil)])
    ]
    var completedTrackers: [TrackerRecord]?
    var currentDate: Date?
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
}
