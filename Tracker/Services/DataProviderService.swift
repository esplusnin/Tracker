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
    var trackersViewController: TrackersViewControllerProtocol?
    
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
                    name: "Приготовить обед",
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
    
    var visibleCategories: [TrackerCategory]?
    var completedTrackers: [TrackerRecord]?
    
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
    
    func resetNewTrackerInfo() {
        selectedCategoryString = nil
        selectedScheduleString = nil
        trackerName = nil
        trackerColor = nil
        trackerEmoji = nil
        trackerSchedule = nil
    }
    
    func setTrackerPredicate(with word: String) {
        trackerStore?.setPredicate(with: word)
    }
    
    func setupTrackerCategoryDelegate(controller: CategoryViewControllerProtocol) {
        guard let trackerCategoryStore = trackerCategoryStore else { return }
        
        trackerCategoryStore.delegate = controller
    }
    
    func updateTrackersCollection(_ updates: CollectionStoreUpdates) {
        trackersViewController?.reloadCOll()
    }
    
    //MARK: TrackerStore Block:

    func addTrackerToStore(model: Tracker) {
        trackerStore?.addTracker(model: model)
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
    
    func fetchAllCategoriesFromStore() -> [TrackerCategoryCoreData] {
        trackerCategoryStore?.fetchAllCategories() ?? []
    }
    
    func fetchSpecificCategory(name: String) -> TrackerCategoryCoreData? {
        trackerCategoryStore?.fetchSpecificCategory(name: name)
    }
}
