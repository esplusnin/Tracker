//
//  TrackerStorage.swift
//  Tracker
//
//  Created by Евгений on 31.05.2023.
//

import Foundation

final class TrackerStorageService {
    
    static let shared = TrackerStorageService()
    
    private init() {}
    
    var categories: [TrackerCategory]? = [
        TrackerCategory(name: "Важное", trackerDictionary: [
            Tracker(id: UUID(),
                    name: "Сделать проект как красавчик",
                    color: .colorSelection1,
                    emoji: "🐶",
                    schedule: [1,2,3,4,5,6,7]),
            Tracker(id: UUID(),
                    name: "Закончить Avto Layout",
                    color: .colorSelection5,
                    emoji: "🥦",
                    schedule: [1,2,3,4,5,6,7])]),
        TrackerCategory(name: "Английский", trackerDictionary: [
            Tracker(id: UUID(),
                    name: "Домашка + слова",
                    color: .colorSelection10,
                    emoji: "🏝",
                    schedule: [1,2,3,4,5,6,7])])
    ]
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    var visibleCategories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?
}
