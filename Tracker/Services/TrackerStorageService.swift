//
//  TrackerStorage.swift
//  Tracker
//
//  Created by Евгений on 31.05.2023.
//

import UIKit

final class TrackerStorageService {
    
    static let shared = TrackerStorageService()
    
    private init() {}
    
    // Preparing for create new tracker:
    var selectedCategoryString: String?
    var selectedScheduleString: String?
    var trackerName: String?
    var trackerColor: UIColor?
    var trackerEmoji: String?
    var trackerSchedule: [Int]?
    
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
    
    var colorSectionArray: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4,
        .colorSelection5, .colorSelection6, .colorSelection7, .colorSelection8,
        .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16,
        .colorSelection17, .colorSelection18,
    ]
    
    var visibleCategories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?
    
    func resetNewTrackerInfo() {
        selectedCategoryString = nil
        selectedScheduleString = nil
        trackerName = nil
        trackerColor = nil
        trackerEmoji = nil
        trackerSchedule = nil
    }
}
