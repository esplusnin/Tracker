//
//  LocalizableConstants.swift
//  Tracker
//
//  Created by Евгений on 30.06.2023.
//

import UIKit

enum LocalizableConstants {
    enum OnboardingVC {
        static let firstScreenTitle = NSLocalizedString("onboarding.firstScreen.title", comment: "")
        static let secondScreenTitle = NSLocalizedString("onboarding.secondScreen.title", comment: "")
        static let continueButton = NSLocalizedString("onboarding.continueButton", comment: "")
    }
    enum TabBarVC {
        static let trackers = NSLocalizedString("tabBar.trackers", comment: "")
        static let statistics = NSLocalizedString("tabBar.statistics", comment: "")
    }
    
    enum TrackerVC {
        static let title = NSLocalizedString("trackerVC.title", comment: "")
        static let searchFieldPlaceholder = NSLocalizedString("trackerVC.searchField.placeholder", comment: "")
        static let cancelationButton = NSLocalizedString("trackerVC.cancelationButton", comment: "")
        static let emptyStateLabel = NSLocalizedString("trackerVC.emptyState.label", comment: "")
        static let nothingSearched = NSLocalizedString("trackerVC.nothingSearched", comment: "")
        static let pinned = NSLocalizedString("trackerVC.pinned", comment: "")
        
        static func countOfCompletedDays(countOfDays: Int) -> String {
            String.localizedStringWithFormat(NSLocalizedString("numberOfDays", comment: ""), countOfDays)
        }
    }
    
    enum FilterVC {
        static let title = NSLocalizedString("filter.title", comment: "")
        static let allTrackers = NSLocalizedString("filter.allTrackers", comment: "")
        static let todaysTrackers = NSLocalizedString("filter.todaysTrackers", comment: "")
        static let completedTrackers = NSLocalizedString("filter.completedTrackers", comment: "")
        static let uncompletedTrackers = NSLocalizedString("filter.uncompletedTrackers", comment: "")
    }
    
    enum CreatingTrackerVC {
        static let title = NSLocalizedString("creatingTracker.title", comment: "")
        static let habit = NSLocalizedString("creatingTracker.habit", comment: "")
        static let unregularEvent = NSLocalizedString("creatingTracker.unregularEvent", comment: "")
    }
    
    enum NewTrackerVC {
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
    
    enum CategoryVC {
        static let title = NSLocalizedString("category.title", comment: "")
        static let addCategory = NSLocalizedString("category.addCategory", comment: "")
        static let emptyCategory = NSLocalizedString("category.emptyCategory", comment: "")
    }
    
    enum NewCategoryVC {
        static let title = NSLocalizedString("newCategory.title", comment: "")
        static let textFieldPlaceholder = NSLocalizedString("newCategory.textField.placeholder", comment: "")
        static let readyButton = NSLocalizedString("newCategory.readyButton", comment: "")
    }
    
    enum EditingCategory {
        static let title = NSLocalizedString("editingCategory.title", comment: "")
        static let completeButton = NSLocalizedString("editingCategory.completeButton", comment: "")
    }
    
    enum ScheduleVC {
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
    
    enum StatisticsVC {
        static let title = NSLocalizedString("statistics.title", comment: "")
        static let nothingToAnalyze = NSLocalizedString("statistics.nothingToAnalyze", comment: "")
    }
    
    enum AlertsVC {
        static let removeCategoryTitle = NSLocalizedString("alert.removeCategory.title", comment: "")
        static let removeCategoryMessage = NSLocalizedString("alert.removeCategory.message", comment: "")
        static let removeTrackerTitle = NSLocalizedString("alert.removeTracker.title", comment: "")
        static let remove = NSLocalizedString("alert.remove", comment: "")
        static let cancel = NSLocalizedString("alert.cancel", comment: "")
    }
    
    enum ContextMenuVC {
        static let remove = NSLocalizedString("contextMenu.remove", comment: "")
        static let edit = NSLocalizedString("contextMenu.edit", comment: "")
        static let fix = NSLocalizedString("contextMenu.fix", comment: "")
        static let unfix = NSLocalizedString("contextMenu.unfix", comment: "")
    }
    
    enum EditingHabit {
        static let title = NSLocalizedString("editingTracker.title", comment: "")
        static let saveButton = NSLocalizedString("editingTracker.saveChanges", comment: "")
    }
}
