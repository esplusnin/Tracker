// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Plural format key: "%#@days@"
  internal static func numberOfDays(_ p1: Int) -> String {
    return L10n.tr("Localizable", "numberOfDays", p1, fallback: "Plural format key: \"%#@days@\"")
  }
  internal enum Alert {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "alert.cancel", fallback: "Cancel")
    /// Remove
    internal static let remove = L10n.tr("Localizable", "alert.remove", fallback: "Remove")
    internal enum RemoveCategory {
      /// Deleting a category will result in the loss of all its trackers
      internal static let message = L10n.tr("Localizable", "alert.removeCategory.message", fallback: "Deleting a category will result in the loss of all its trackers")
      /// Is this category definitely not needed?
      internal static let title = L10n.tr("Localizable", "alert.removeCategory.title", fallback: "Is this category definitely not needed?")
    }
    internal enum RemoveTracker {
      /// Are you sure you want to delete the tracker?
      internal static let title = L10n.tr("Localizable", "alert.removeTracker.title", fallback: "Are you sure you want to delete the tracker?")
    }
  }
  internal enum Category {
    /// Add category
    internal static let addCategory = L10n.tr("Localizable", "category.addCategory", fallback: "Add category")
    /// Habits and events can be
    /// combined in meaning
    internal static let emptyCategory = L10n.tr("Localizable", "category.emptyCategory", fallback: "Habits and events can be\ncombined in meaning")
    /// Category
    internal static let title = L10n.tr("Localizable", "category.title", fallback: "Category")
  }
  internal enum ContextMenu {
    /// Edit
    internal static let edit = L10n.tr("Localizable", "contextMenu.edit", fallback: "Edit")
    /// Pin
    internal static let fix = L10n.tr("Localizable", "contextMenu.fix", fallback: "Pin")
    /// Remove
    internal static let remove = L10n.tr("Localizable", "contextMenu.remove", fallback: "Remove")
    /// Unpin
    internal static let unfix = L10n.tr("Localizable", "contextMenu.unfix", fallback: "Unpin")
  }
  internal enum CreatingTracker {
    /// Habit
    internal static let habit = L10n.tr("Localizable", "creatingTracker.habit", fallback: "Habit")
    /// Creating a tracker
    internal static let title = L10n.tr("Localizable", "creatingTracker.title", fallback: "Creating a tracker")
    /// Unregular event
    internal static let unregularEvent = L10n.tr("Localizable", "creatingTracker.unregularEvent", fallback: "Unregular event")
  }
  internal enum EditingCategory {
    /// Complete
    internal static let completeButton = L10n.tr("Localizable", "editingCategory.completeButton", fallback: "Complete")
    /// Editing category
    internal static let title = L10n.tr("Localizable", "editingCategory.title", fallback: "Editing category")
  }
  internal enum EditingTracker {
    /// Save changes
    internal static let saveChanges = L10n.tr("Localizable", "editingTracker.saveChanges", fallback: "Save changes")
    /// Editing habit
    internal static let title = L10n.tr("Localizable", "editingTracker.title", fallback: "Editing habit")
  }
  internal enum Filter {
    /// All trackers
    internal static let allTrackers = L10n.tr("Localizable", "filter.allTrackers", fallback: "All trackers")
    /// Completed
    internal static let completedTrackers = L10n.tr("Localizable", "filter.completedTrackers", fallback: "Completed")
    /// Filters
    internal static let title = L10n.tr("Localizable", "filter.title", fallback: "Filters")
    /// Trackers for today
    internal static let todaysTrackers = L10n.tr("Localizable", "filter.todaysTrackers", fallback: "Trackers for today")
    /// Uncompleted
    internal static let uncompletedTrackers = L10n.tr("Localizable", "filter.uncompletedTrackers", fallback: "Uncompleted")
  }
  internal enum NewCategory {
    /// Complete
    internal static let readyButton = L10n.tr("Localizable", "newCategory.readyButton", fallback: "Complete")
    /// New category
    internal static let title = L10n.tr("Localizable", "newCategory.title", fallback: "New category")
    internal enum TextField {
      /// Enter the category name
      internal static let placeholder = L10n.tr("Localizable", "newCategory.textField.placeholder", fallback: "Enter the category name")
    }
  }
  internal enum NewTracker {
    /// Emoji
    internal static let emoji = L10n.tr("Localizable", "newTracker.emoji", fallback: "Emoji")
    /// Limit of 38 characters
    internal static let warning = L10n.tr("Localizable", "newTracker.warning", fallback: "Limit of 38 characters")
    internal enum Buttons {
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "newTracker.buttons.cancel", fallback: "Cancel")
      /// Create
      internal static let create = L10n.tr("Localizable", "newTracker.buttons.create", fallback: "Create")
    }
    internal enum CollectionView {
      /// Color
      internal static let color = L10n.tr("Localizable", "newTracker.collectionView.color", fallback: "Color")
    }
    internal enum Habit {
      /// New habit
      internal static let title = L10n.tr("Localizable", "newTracker.habit.title", fallback: "New habit")
    }
    internal enum TableView {
      /// Category
      internal static let category = L10n.tr("Localizable", "newTracker.tableView.category", fallback: "Category")
      /// Schedule
      internal static let schedule = L10n.tr("Localizable", "newTracker.tableView.schedule", fallback: "Schedule")
    }
    internal enum TextField {
      /// Enter the name of the tracker
      internal static let placeholder = L10n.tr("Localizable", "newTracker.textField.placeholder", fallback: "Enter the name of the tracker")
    }
    internal enum UnregularEvent {
      /// New unregular event
      internal static let title = L10n.tr("Localizable", "newTracker.unregularEvent.title", fallback: "New unregular event")
    }
  }
  internal enum Onboarding {
    /// These are the technologies!
    internal static let continueButton = L10n.tr("Localizable", "onboarding.continueButton", fallback: "These are the technologies!")
    internal enum FirstScreen {
      /// Track only what you want
      internal static let title = L10n.tr("Localizable", "onboarding.firstScreen.title", fallback: "Track only what you want")
    }
    internal enum SecondScreen {
      /// Even if it's not liters of water and yoga
      internal static let title = L10n.tr("Localizable", "onboarding.secondScreen.title", fallback: "Even if it's not liters of water and yoga")
    }
  }
  internal enum Schedule {
    /// Every day
    internal static let everyDay = L10n.tr("Localizable", "schedule.everyDay", fallback: "Every day")
    /// Friday
    internal static let friday = L10n.tr("Localizable", "schedule.friday", fallback: "Friday")
    /// Monday
    internal static let monday = L10n.tr("Localizable", "schedule.monday", fallback: "Monday")
    /// Complete
    internal static let ready = L10n.tr("Localizable", "schedule.ready", fallback: "Complete")
    /// Saturday
    internal static let saturday = L10n.tr("Localizable", "schedule.saturday", fallback: "Saturday")
    /// Sunday
    internal static let sunday = L10n.tr("Localizable", "schedule.sunday", fallback: "Sunday")
    /// Thursday
    internal static let thursday = L10n.tr("Localizable", "schedule.thursday", fallback: "Thursday")
    /// Schedule
    internal static let title = L10n.tr("Localizable", "schedule.title", fallback: "Schedule")
    /// Tuesday
    internal static let tuesday = L10n.tr("Localizable", "schedule.tuesday", fallback: "Tuesday")
    /// Wednesday
    internal static let wednesday = L10n.tr("Localizable", "schedule.wednesday", fallback: "Wednesday")
    internal enum Friday {
      /// Fri
      internal static let short = L10n.tr("Localizable", "schedule.friday.short", fallback: "Fri")
    }
    internal enum Monday {
      /// Mon
      internal static let short = L10n.tr("Localizable", "schedule.monday.short", fallback: "Mon")
    }
    internal enum Saturday {
      /// Sut
      internal static let short = L10n.tr("Localizable", "schedule.saturday.short", fallback: "Sut")
    }
    internal enum Sunday {
      /// Sun
      internal static let short = L10n.tr("Localizable", "schedule.sunday.short", fallback: "Sun")
    }
    internal enum Thursday {
      /// Thur
      internal static let short = L10n.tr("Localizable", "schedule.thursday.short", fallback: "Thur")
    }
    internal enum Tuesday {
      /// Tue
      internal static let short = L10n.tr("Localizable", "schedule.tuesday.short", fallback: "Tue")
    }
    internal enum Wednesday {
      /// Wed
      internal static let short = L10n.tr("Localizable", "schedule.wednesday.short", fallback: "Wed")
    }
  }
  internal enum Statistics {
    /// Average value
    internal static let averageValue = L10n.tr("Localizable", "statistics.averageValue", fallback: "Average value")
    /// The best period
    internal static let bestPeriod = L10n.tr("Localizable", "statistics.bestPeriod", fallback: "The best period")
    /// There is nothing to analyze yet
    internal static let nothingToAnalyze = L10n.tr("Localizable", "statistics.nothingToAnalyze", fallback: "There is nothing to analyze yet")
    /// Perfect day
    internal static let perfectDays = L10n.tr("Localizable", "statistics.perfectDays", fallback: "Perfect day")
    /// Statistics
    internal static let title = L10n.tr("Localizable", "statistics.title", fallback: "Statistics")
    /// Trackers completed
    internal static let totalCompletedTracker = L10n.tr("Localizable", "statistics.totalCompletedTracker", fallback: "Trackers completed")
  }
  internal enum TabBar {
    /// Statistics
    internal static let statistics = L10n.tr("Localizable", "tabBar.statistics", fallback: "Statistics")
    /// Trackers
    internal static let trackers = L10n.tr("Localizable", "tabBar.trackers", fallback: "Trackers")
  }
  internal enum TrackerVC {
    /// Cancel
    internal static let cancelationButton = L10n.tr("Localizable", "trackerVC.cancelationButton", fallback: "Cancel")
    /// Nothing found
    internal static let nothingSearched = L10n.tr("Localizable", "trackerVC.nothingSearched", fallback: "Nothing found")
    /// Pinned
    internal static let pinned = L10n.tr("Localizable", "trackerVC.pinned", fallback: "Pinned")
    /// Trackers
    internal static let title = L10n.tr("Localizable", "trackerVC.title", fallback: "Trackers")
    internal enum EmptyState {
      /// What we will track?
      internal static let label = L10n.tr("Localizable", "trackerVC.emptyState.label", fallback: "What we will track?")
    }
    internal enum SearchField {
      /// Search...
      internal static let placeholder = L10n.tr("Localizable", "trackerVC.searchField.placeholder", fallback: "Search...")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
