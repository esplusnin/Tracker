//
//  LocalizableConstants.swift
//  Tracker
//
//  Created by Евгений on 30.06.2023.
//

import UIKit

enum LocalizableConstants {
    enum Onboarding {
        static let firstScreenTitle = NSLocalizedString("onboarding.firstScreen.title", comment: "")
        static let secondScreenTitle = NSLocalizedString("onboarding.secondScreen.title", comment: "")
        static let continueButton = NSLocalizedString("onboarding.continueButton", comment: "")
    }
    enum TabBar {
        static let trackers = NSLocalizedString("tabBar.trackers", comment: "")
        static let statistics = NSLocalizedString("tabBar.statistics", comment: "")
    }
    
    enum TrackerVC {
        static let title = NSLocalizedString("trackerVC.title", comment: "")
        static let searchFieldPlaceholder = NSLocalizedString("trackerVC.searchField.placeholder", comment: "")
        static let cancelationButton = NSLocalizedString("trackerVC.cancelationButton", comment: "")
        static let emptyStateLabel = NSLocalizedString("trackerVC.emptyState.label", comment: "")
        static let nothingSearched = NSLocalizedString("trackerVC.nothingSearched", comment: "")
        static func countOfCompletedDays(countOfDays: Int) -> String { String.localizedStringWithFormat(NSLocalizedString("numberOfDays", comment: ""), countOfDays)
        }
    }
    
    enum CreatingTracker {
        static let title = NSLocalizedString("creatingTracker.title", comment: "")
        static let habit = NSLocalizedString("creatingTracker.habit", comment: "")
        static let unregularEvent = NSLocalizedString("creatingTracker.unregularEvent", comment: "")
    }
    
    enum NewTracker {
        static let habitTitle = NSLocalizedString("newTracker.habit.title", comment: "")
        static let unregularTitle = NSLocalizedString("newTracker.habit.title", comment: "")
        static let textFieldPlaceholder = NSLocalizedString("newTracker.textField.placeholder", comment: "")
        static let tableViewCategory = NSLocalizedString("newTracker.tableView.category", comment: "")
        static let tableViewSchedule = NSLocalizedString("newTracker.tableView.schedule", comment: "")
        static let collectionViewColor = NSLocalizedString("newTracker.collectionView.color", comment: "")
        static let buttonCancel = NSLocalizedString("newTracker.buttons.cancel", comment: "")
        static let buttonCreate = NSLocalizedString("newTracker.buttons.create", comment: "")
        static let warning = NSLocalizedString("newTracker.warning", comment: "")
        static let emoji = NSLocalizedString("newTracker.emoji", comment: "")
    }
    
    enum Category {
        static let title = NSLocalizedString("category.title", comment: "")
        static let addCategory = NSLocalizedString("category.addCategory", comment: "")
        static let emptyCategory = NSLocalizedString("category.emptyCategory", comment: "")
    }
    
    enum NewCategory {
        static let title = NSLocalizedString("newCategory.title", comment: "")
        static let textFieldPlaceholder = NSLocalizedString("newCategory.textField.placeholder", comment: "")
        static let readyButton = NSLocalizedString("newCategory.readyButton", comment: "")
    }
    
    enum Schedule {
        static let title = NSLocalizedString("schedule.title", comment: "")
        static let monday = NSLocalizedString("schedule.monday", comment: "")
        static let tuesday = NSLocalizedString("schedule.tuesday", comment: "")
        static let wednesday = NSLocalizedString("schedule.wednesday", comment: "")
        static let thursday = NSLocalizedString("schedule.thursday", comment: "")
        static let friday = NSLocalizedString("schedule.friday", comment: "")
        static let saturday = NSLocalizedString("schedule.saturday", comment: "")
        static let sunday = NSLocalizedString("schedule.sunday", comment: "")
        static let everyDay = NSLocalizedString("schedule.everyDay", comment: "")
        static let ready = NSLocalizedString("schedule.ready", comment: "")
        
        static let mondayShort = NSLocalizedString("schedule.monday.short", comment: "")
        static let tuesdayShort = NSLocalizedString("schedule.tuesday.short", comment: "")
        static let wednesdayShort = NSLocalizedString("schedule.wednesday.short", comment: "")
        static let thursdayShort = NSLocalizedString("schedule.thursday.short", comment: "")
        static let fridayShort = NSLocalizedString("schedule.friday.short", comment: "")
        static let saturdayShort = NSLocalizedString("schedule.saturday.short", comment: "")
        static let sundayShort = NSLocalizedString("schedule.sunday.short", comment: "")
    }
    
    enum Statistics {
        static let title = NSLocalizedString("statistics.title", comment: "")
        static let nothingToAnalyze = NSLocalizedString("statistics.nothingToAnalyze", comment: "")
    }
}
