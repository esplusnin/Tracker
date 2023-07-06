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

    // MARK: TrackerVC:
    func testTrackerViewController() {
        assertSnapshots(matching: trackersViewController, as: [.image])
    }
    
    func testTrackerViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController, as: [.recursiveDescription])
    }
    
    func testAddTrackerButtonTrackersViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.addTrackerButton, as: [.image])
    }
    
    func testAddTrackerButtonTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.addTrackerButton, as: [.recursiveDescription])
    }
    
    func testDatePickerTrackersViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.navigationBarDatePicker, as: [.image])
    }
    
    func testDatePickerTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.navigationBarDatePicker, as: [.recursiveDescription])
    }
    
    func testSearchFieldTrackerViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField, as: [.image])
    }
    
    func testSearchFieldTrackerViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.searchTextField, as: [.recursiveDescription])
    }
    
    func testFilterButtonTrackerViewController() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton, as: [.image])
    }
    
    func testFilterButtonTrackerViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.filterButton, as: [.recursiveDescription])
    }
    
    func testCollectionViewTrackersViewControllerRecursive() {
        assertSnapshots(matching: trackersViewController.trackersView.trackersCollection, as: [.recursiveDescription])
    }
    
    // MARK: Statistics ViewController:
    
    func testStatisticsViewController() {
        assertSnapshots(matching: statisticsViewController, as: [.image])
    }
    
    func testStatisticsViewControllerRecursive() {
        assertSnapshots(matching: statisticsViewController, as: [.recursiveDescription])
    }
    
    func testDumbLabelViewStatisticsViewController() {
        assertSnapshots(matching: statisticsViewController.statisticView.emptyStatisticLabel, as: [.image])
    }
    
    func testDumbLabelViewStatisticsViewControllerRecursive() {
        assertSnapshots(matching: statisticsViewController.statisticView.emptyStatisticLabel, as: [.recursiveDescription])
    }
    
    // MARK: CreatingTrackerViewController:
    
    func testHabiButtonCreatingTrackerController() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.habitCreateButton, as: [.image])
    }
    
    func testHabiButtonCreatingTrackerControllerRecursive() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.habitCreateButton, as: [.recursiveDescription])
    }
    
    func testUnregularEventButtonCreatingTrackerController() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.unregularEventCreateButton, as: [.image])
    }
    
    func testUnregularEventButtonCreatingTrackerControllerRecursive() {
        assertSnapshots(matching: creatingTrackersViewController.creatingTrackerView.unregularEventCreateButton, as: [.image])
    }
    
    //MARK: NewTrackerViewController:
    
    func testTextFieldNewTrackerViewController() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.textField, as: [.image])
    }
    
    func testTextFieldNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.textField, as: [.image])
    }
    
    func testTableViewNewTrackerViewControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.tableView, as: [.recursiveDescription])
    }
    
    func testCollectionViewNewTrackerControllerRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.collectionView, as: [.recursiveDescription])
    }
    
    func testNewTrackerControllerCreateButton() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton, as: [.image])
    }
    
    func testNewTrackerControllerCreateButtonRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.createButton, as: [.recursiveDescription])
    }
    
    func testNewTrackerControllerCancelButton() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton, as: [.image])
    }
    
    func testNewTrackerControllerCancelButtonRecursive() {
        assertSnapshots(matching: newTrackerViewController.newTrackerView.cancelButton, as: [.recursiveDescription])
    }
    
    // MARK: CategoryViewController:
    
    func testCategoryViewController() {
        assertSnapshots(matching: categoryViewController, as: [.image])
    }
    
    func testCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController, as: [.recursiveDescription])
    }
    
    func testTableViewCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController.categoryView.tableView, as: [.recursiveDescription])
    }
    
    func testCreateButtonCategoryViewController() {
        assertSnapshots(matching: categoryViewController.categoryView.createCategoryButton, as: [.image])
    }
    
    func testCreateButtonCategoryViewControllerRecursive() {
        assertSnapshots(matching: categoryViewController.categoryView.createCategoryButton, as: [.recursiveDescription])
    }
    
    // MARK: ScheduleViewController:
    
    func testScheduleViewController() {
        assertSnapshots(matching: scheduleViewController, as: [.image])
    }
    
    func testScheduleViewControllerRecursive() {
        assertSnapshots(matching: scheduleViewController, as: [.recursiveDescription])
    }
    
    func testTableViewScheduleViewControllerRecursive() {
        assertSnapshots(matching: scheduleViewController.scheduleView.scheduleTableView, as: [.recursiveDescription])
    }
    
    func testCompleteButtonSchedulteViewController() {
        assertSnapshots(matching: scheduleViewController.scheduleView.completeButton, as: [.image])
    }
    
    func testCompleteButtonSchedulteViewControllerRecursive() {
            assertSnapshots(matching: scheduleViewController.scheduleView.completeButton, as: [.recursiveDescription])
    }
}
