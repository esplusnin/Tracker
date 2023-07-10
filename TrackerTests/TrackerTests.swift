//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Евгений on 06.07.2023.
//

import XCTest
import SnapshotTesting
@testable import Tracker

// MARK: Tests available for iPhone 14

final class TrackerTests: XCTestCase {
    let trackersViewController = TrackersViewController()
    let statisticsViewController = StatisticViewController()
    let creatingTrackersViewController = CreatingTrackerViewController()
    let newTrackerViewController = NewTrackerViewController()
    let categoryViewController = CategoryViewController()
    let scheduleViewController = ScheduleViewController()

// MARK: Light theme:
    // MARK: TrackerVC:
    func testTrackerViewController() {
        assertSnapshots(matching: trackersViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTrackerViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testAddTrackerButtonTrackersViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.addTrackerButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testAddTrackerButtonTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.addTrackerButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testSearchFieldTrackerViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testSearchFieldTrackerViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testFilterButtonTrackerViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testFilterButtonTrackerViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as:[.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCollectionViewTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.trackersCollection,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    // MARK: Statistics ViewController:
    
    func testStatisticsViewController() {
        assertSnapshots(matching: statisticsViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testStatisticsViewControllerRecursive() {
        assertSnapshots(matching: statisticsViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testDumbLabelViewStatisticsViewController() {
        assertSnapshots(matching: statisticsViewController.statisticView.emptyStatisticLabel,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testDumbLabelViewStatisticsViewControllerRecursive() {
        assertSnapshots(matching: statisticsViewController.statisticView.emptyStatisticLabel,
                        as:[.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    // MARK: CreatingTrackerViewController:
    
    func testHabiButtonCreatingTrackerController() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.habitCreateButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testHabiButtonCreatingTrackerControllerRecursive() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.habitCreateButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testUnregularEventButtonCreatingTrackerController() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.unregularEventCreateButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testUnregularEventButtonCreatingTrackerControllerRecursive() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.unregularEventCreateButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    //MARK: NewTrackerViewController:
    
    func testTextFieldNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.textField,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTextFieldNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.textField,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTableViewNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.tableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCollectionViewNewTrackerControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.collectionView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testNewTrackerControllerCreateButton() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testNewTrackerControllerCreateButtonRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testNewTrackerControllerCancelButton() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testNewTrackerControllerCancelButtonRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    // MARK: CategoryViewController:
    
    func testCategoryViewController() {
        assertSnapshots(matching: categoryViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTableViewCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController.categoryView.tableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCreateButtonCategoryViewController() {
        assertSnapshots(matching: categoryViewController.categoryView.createCategoryButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCreateButtonCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController.categoryView.createCategoryButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    // MARK: ScheduleViewController:
    
    func testScheduleViewController() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testScheduleViewControllerRecursive() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testTableViewScheduleViewControllerRecursive() {
        assertSnapshots(matching: scheduleViewController.scheduleView.scheduleTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCompleteButtonSchedulteViewController() {
        assertSnapshots(matching: scheduleViewController.scheduleView.completeButton,
                        as: [.image(traits: .init(userInterfaceStyle: .light))])
    }
    
    func testCompleteButtonSchedulteViewControllerRecursive() {
            assertSnapshots(matching: scheduleViewController.scheduleView.completeButton,
                            as: [.recursiveDescription(traits: .init(userInterfaceStyle: .light))])
    }
    
    
// MARK: Black theme:
    // MARK: TrackerVC:
    func testTrackerViewControllerBlack() {
        assertSnapshots(matching: trackersViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTrackerViewControllerRecursiveBlack() {
        assertSnapshots(matching: trackersViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testAddTrackerButtonTrackersViewControllerBlack() {
        assertSnapshots(matching: trackersViewController.trackersView.addTrackerButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testAddTrackerButtonTrackersViewControllerRecursiveBlack() {
        assertSnapshots(matching: trackersViewController.trackersView.addTrackerButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testSearchFieldTrackerViewControllerBlack() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testSearchFieldTrackerViewControllerRecursiveBlack() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testFilterButtonTrackerViewControllerBlack() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testFilterButtonTrackerViewControllerRecursiveBlack() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCollectionViewTrackersViewControllerRecursiveBlack() {
        assertSnapshots(matching: trackersViewController.trackersView.trackersCollection,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    // MARK: Statistics ViewController:
    
    func testStatisticsViewControllerBlack() {
        assertSnapshots(matching: statisticsViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testStatisticsViewControllerRecursiveBlack() {
        assertSnapshots(matching: statisticsViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testDumbLabelViewStatisticsViewControllerBlack() {
        assertSnapshots(matching: statisticsViewController.statisticView.emptyStatisticLabel,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testDumbLabelViewStatisticsViewControllerRecursiveBlack() {
        assertSnapshots(matching: statisticsViewController.statisticView.emptyStatisticLabel,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    // MARK: CreatingTrackerViewController:
    
    func testHabiButtonCreatingTrackerControllerBlack() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.habitCreateButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testHabiButtonCreatingTrackerControllerRecursiveBlack() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.habitCreateButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testUnregularEventButtonCreatingTrackerControllerBlack() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.unregularEventCreateButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testUnregularEventButtonCreatingTrackerControllerRecursiveBlack() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.unregularEventCreateButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    //MARK: NewTrackerViewController:
    
    func testTextFieldNewTrackerViewControllerBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.textField,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTextFieldNewTrackerViewControllerRecursiveBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.textField,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTableViewNewTrackerViewControllerRecursiveBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.tableView,
                        as:[.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCollectionViewNewTrackerControllerRecursiveBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.collectionView,
                        as:[.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testNewTrackerControllerCreateButtonBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testNewTrackerControllerCreateButtonRecursiveBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testNewTrackerControllerCancelButtonBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testNewTrackerControllerCancelButtonRecursiveBlack() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    // MARK: CategoryViewController:
    
    func testCategoryViewControllerBlack() {
        assertSnapshots(matching: categoryViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCategoryViewControllerRecursiveBlack() {
        assertSnapshots(matching: categoryViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTableViewCategoryViewControllerRecursiveBlack() {
        assertSnapshots(matching: categoryViewController.categoryView.tableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCreateButtonCategoryViewControllerBlack() {
        assertSnapshots(matching: categoryViewController.categoryView.createCategoryButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCreateButtonCategoryViewControllerRecursiveBlack() {
        assertSnapshots(matching: categoryViewController.categoryView.createCategoryButton,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    // MARK: ScheduleViewController:
    
    func testScheduleViewControllerBlack() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testScheduleViewControllerRecursiveBlack() {
        assertSnapshots(matching: scheduleViewController,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testTableViewScheduleViewControllerRecursiveBlack() {
        assertSnapshots(matching: scheduleViewController.scheduleView.scheduleTableView,
                        as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCompleteButtonSchedulteViewControllerBlack() {
        assertSnapshots(matching: scheduleViewController.scheduleView.completeButton,
                        as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
    
    func testCompleteButtonSchedulteViewControllerRecursiveBlack() {
            assertSnapshots(matching: scheduleViewController.scheduleView.completeButton,
                            as: [.recursiveDescription(traits: .init(userInterfaceStyle: .dark))])
    }
}
