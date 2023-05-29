//
//  NewHabitPresenter.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import Foundation

enum KindOfTrackers {
    case habit
    case unregularEvent
}

final class NewTrackerPresenter {
    let buttonsTitleForTableView = ["Категория", "Расписание"]
    let emojiForCollectionView: [String] = []
    
    var selectedDays: [String] = []
}
