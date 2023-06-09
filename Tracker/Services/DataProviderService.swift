//
//  DataProviderService.swift
//  Tracker
//
//  Created by Евгений on 31.05.2023.
//

import UIKit

struct CollectionStoreUpdates {
    let insertedIndex: IndexSet
    let deletedIndex: IndexSet
}

final class DataProviderService {
    
    static let instance = DataProviderService()
    
    var trackerStore: TrackerStoreProtocol?
    var trackerCategoryStore: TrackerCategoryStoreProtocol?
    var trackerRecordStore: TrackerRecordStore?
    var trackersViewController: TrackersViewControllerProtocol?
    
    private init() {}
    
    // Preparing for create new tracker:
    var selectedCategoryString: String?
    var selectedScheduleString: String?
    var trackerName: String?
    var trackerColor: UIColor?
    var trackerEmoji: String?
    var trackerSchedule: [Int]?
    
    private var visibleCategories: [TrackerCategory]?
    private var completedTrackers: [TrackerRecord]?
    
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
    
    func setTrackerStoreDelegate(view: TrackersDataProviderDelegate) {
        trackerStore?.delegate = view
    }
    
    // Getting and Setting operating arrays:
    func getVisiblieCategories() -> [TrackerCategory] {
        visibleCategories ?? []
    }
    
    func setVisibleCategory(_ category: [TrackerCategory]) {
        visibleCategories = category
    }
    
    func getTrackerRecords() -> [TrackerRecord] {
        completedTrackers ?? []
    }
    
    func setTrackerRecords(_ records: [TrackerRecord]) {
        completedTrackers = records
    }
    
    func inizializeVisibleCategories() {
        visibleCategories = trackerStore?.fetchTrackers()
    }
    
    func resetNewTrackerInfo() {
        selectedCategoryString = nil
        selectedScheduleString = nil
        trackerName = nil
        trackerColor = nil
        trackerEmoji = nil
        trackerSchedule = nil
    }
    
    func updateTrackersCollection(_ updates: CollectionStoreUpdates) {
        trackersViewController?.reloadCollectionView()
    }
    
    //MARK: TrackerStore Block:
    func addTrackerToStore(model: Tracker) {
        trackerStore?.addTracker(model: model)
    }
    
    func editTrackerFromStore(id: UUID) {
        trackerStore?.editTracker(id: id)
    }
    
    func deleteTrackerFromStore(id: UUID) {
        trackerStore?.deleteTracker(id: id)
    }
    
    func getTrackersFromStore(categoryName: String, index: Int) -> Tracker {
        let tracker = trackerStore?.getTracker(categoryName: categoryName, searchedindex: index)
        
        return Tracker(id: tracker?.id ?? UUID(),
                       name: tracker?.name ?? "",
                       color: tracker?.color ?? .clear,
                       emoji: tracker?.emoji ?? "",
                       schedule: tracker?.schedule ?? [])
    }
    
    //MARK: TrackerCategoryStore Block:
    func getNumberOfCategories() -> Int {
        trackerCategoryStore?.numberOfCategories() ?? 0
    }
    
    func getNumberOfRowsInSection(at section: Int) -> Int {
        trackerCategoryStore?.numberOfRowsInSection(at: section) ?? 0
    }
    
    func addCategoryToStore(name: String) {
        trackerCategoryStore?.addCategory(name: name)
    }
    
    func getCategoryNameFromStore(at index: Int) -> String {
        trackerCategoryStore?.getCategoryName(at: index) ?? ""
    }

    func fetchSpecificCategory(name: String) -> TrackerCategoryCoreData? {
        trackerCategoryStore?.fetchSpecificCategory(name: name)
    }
    
    func setupTrackerCategoryDelegate(controller: TrackersCategoryDelegate) {
        guard let trackerCategoryStore = trackerCategoryStore else { return }
        
        trackerCategoryStore.delegate = controller
    }
    
    //MARK: TrackerRecord Block:
    func setAllTrackerRecords() {
        completedTrackers = trackerRecordStore?.getTrackerRecords()
    }
    
    func changeStatusTrackerRecord(model: TrackerRecord, isAddDay: Bool) {
        if isAddDay {
            trackerRecordStore?.addRecord(tracker: model)
        } else {
            trackerRecordStore?.deleteRecord(tracker: model)
        }
    }
}
