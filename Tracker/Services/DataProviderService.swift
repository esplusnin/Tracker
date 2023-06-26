//
//  DataProviderService.swift
//  Tracker
//
//  Created by Евгений on 31.05.2023.
//

import UIKit

final class DataProviderService {
    
    static let instance = DataProviderService()
    
    //CoreData Stores:
    var trackerStore: TrackerStoreProtocol?
    var trackerCategoryStore: TrackerCategoryStoreProtocol?
    var trackerRecordStore: TrackerRecordStore?
    
    // ViewModels:
    var categoryViewModel: CategoryViewModelProtocol?
    var scheduleViewModel: ScheduleViewModelProtocol?
    var newTrackerViewModel: NewTrackerViewModelProtocol?
    var trackersViewModel: TrackersViewModelProtocol?
    
    private init() {}
    
    // Preparing for create new tracker:
    var selectedCategoryString: String? {
        didSet {
            newTrackerViewModel?.isControllerReadyToCreateNewTracker()
        }
    }
    var selectedScheduleString: String? {
        didSet {
            isScheduleViewModelReadyToSave()
            newTrackerViewModel?.isControllerReadyToCreateNewTracker()
        }
    }
    var trackerName: String? {
        didSet {
            newTrackerViewModel?.isControllerReadyToCreateNewTracker()
        }
    }
    var trackerColor: UIColor? {
        didSet {
            newTrackerViewModel?.isControllerReadyToCreateNewTracker()
        }
    }
    var trackerEmoji: String? {
        didSet {
            newTrackerViewModel?.isControllerReadyToCreateNewTracker()
        }
    }
    var trackerSchedule: [Int]? {
        didSet {
            isScheduleViewModelReadyToSave()
        }
    }
    
    private var visibleCategories: [TrackerCategory]?
    private var completedTrackers: [TrackerRecord]?
    private var categoryNames: [String]? {
        didSet {
            categoryViewModel?.updateVisibleCategories()
        }
    }
    
    func isCurrentDayFromScheduleExist(_ day: Int) -> Bool {
        guard let trackerSchedule = trackerSchedule else { return false }
        
        return trackerSchedule.contains(day) ? true : false
    }
    
    func isScheduleDidCreate() -> Bool{
        trackerSchedule != nil
    }
    
    func isScheduleStringDidFilled() -> Bool {
        selectedScheduleString != nil
    }
    
    func isScheduleViewModelReadyToSave() {
        if isScheduleDidCreate() && isScheduleStringDidFilled() {
            scheduleViewModel?.changeStatusToCloseSchedule()
        }
    }
    
    func isTrackerParametersWasFilled() -> Bool {
        return trackerName != nil && trackerColor != nil &&
        trackerEmoji != nil && selectedCategoryString != nil ? true : false
    }
    
    // Getting and Setting operating arrays:
    func getVisiblieCategories() -> [TrackerCategory] {
        return visibleCategories ?? []
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
    
    //MARK: ViewModels Block:
    func updateCategoryViewModel() -> [String] {
        categoryNames ?? []
    }
    
    func trackerDidCreate() {
        trackersViewModel?.setVisibleTrackersFromProvider()
        newTrackerViewModel?.trackerDidCreate()
    }
    
    func recordDidUpdate() {
        trackersViewModel?.recordDidUpdate()
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
        trackerCategoryStore?.getNumberOfCategories() ?? 0
    }
    
    func getNumberOfRowsInSection(at section: Int) -> Int {
        trackerCategoryStore?.numberOfRowsInSection(at: section) ?? 0
    }
    
    func addCategoryToStore(name: String) {
        trackerCategoryStore?.addCategory(name: name)
    }
    
    func getCategoryNames() {
        categoryNames = trackerCategoryStore?.fetchCategoryNames()
    }
    
    func getCategoryNameFromStore(at index: Int) -> String {
        trackerCategoryStore?.getCategoryName(at: index) ?? ""
    }
    
    func fetchSpecificCategory(name: String) -> TrackerCategoryCoreData? {
        trackerCategoryStore?.fetchSpecificCategory(name: name)
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
    
    //MARK: Setting Controller protocols:
    func bindCategoryViewModel(controller: CategoryViewModelProtocol) {
        categoryViewModel = controller
    }
    
    func bindScheduleViewModel(controller: ScheduleViewModelProtocol) {
        scheduleViewModel = controller
    }
    
    func bindNewTrackerViewModel(controller: NewTrackerViewModelProtocol) {
        newTrackerViewModel = controller
    }
    
    func bindTrackersViewModel(controller: TrackersViewModelProtocol) {
        trackersViewModel = controller
    }
}
