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
                                                                    color: .colorSelection1,
                                                                    emoji: "🐶",
                                                                    schedule: [1,2,3,4,5,6,7])]),
        TrackerCategory(name: "Английский", trackerDictionary: [Tracker(id: UUID(),
                                                                        name: "Домашка + слова",
                                                                        color: .colorSelection10,
                                                                        emoji: "🏝",
                                                                        schedule: [1,2,3,4,5,6,7])])
    ]
    
    var visibleCategories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?
    var currentDate: Date?
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    func showNewTrackersAfterChanges() {
        guard let categories = categories,
              let date = currentDate else { return }
        
        var newArray: [TrackerCategory] = []
        
        for category in categories {
            var newCategory = TrackerCategory(name: category.name, trackerDictionary: [])
            
            
            for tracker in category.trackerDictionary {
                guard let schedule = tracker.schedule else { return }
                let trackerDate = DateService().getNumberOfCurrentDate(date)
                
                if schedule.contains(trackerDate) {
                    newCategory.trackerDictionary.append(tracker)
                }
            }
            newArray.append(newCategory)
        }
        visibleCategories = newArray
    }
}
