//
//  DataProviderService.swift
//  Tracker
//
//  Created by Евгений on 31.05.2023.
//

import UIKit

final class DataProviderService {
    
    static let instance = DataProviderService()
    
    // CoreData Stores:
    var trackerStore: TrackerStoreProtocol?
    var trackerCategoryStore: TrackerCategoryStoreProtocol?
    var trackerRecordStore: TrackerRecordStore?
    
    // ViewModels:
    var categoryViewModel: CategoryViewModelProtocol?
    var scheduleViewModel: ScheduleViewModelProtocol?
    var newTrackerViewModel: NewTrackerViewModelProtocol?
    var trackersViewModel: TrackersViewModelProtocol?
    var statisticsViewModel: StatisticsViewModelProtocol?
    
    var statisticsService: StatisticsServiceProtocol?
    
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
    
    var currentFilter: String? {
        didSet {
            currentFilterDidUpdate()
        }
    }
    
    private var visibleCategories: [TrackerCategory]? {
        didSet {
            trackersDidChange()
        }
    }
    private var completedTrackers: [TrackerRecord]? {
        didSet {
            setRecordsToStatisticsService()
        }
    }
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
    
    
    // MARK: Getting and Setting operating arrays:
    func getVisiblieCategories() -> [TrackerCategory] {
        return visibleCategories ?? []
    }
    
    func getTrackerRecords() -> [TrackerRecord] {
        completedTrackers ?? []
    }
    
    func setVisibleCategory(_ category: [TrackerCategory]) {
        visibleCategories = category
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
    
    func trackersDidChange() {
        trackersViewModel?.setVisibleTrackersFromProvider()
    }
    
    func recordDidUpdate() {
        trackersViewModel?.recordDidUpdate()
    }
    
    func statisticsDidUpdate() {
        statisticsViewModel?.isStatisticsExists()
    }
    
    // Return string of current localize value from selected filter 
    func currentFilterDidUpdate() {
        switch currentFilter {
        case L10n.Filter.allTrackers:
            trackersViewModel?.showNewTrackersAfterChangeDate()
        case L10n.Filter.todaysTrackers:
            trackersViewModel?.todaysFilterDidEnable()
        case L10n.Filter.completedTrackers:
            trackersViewModel?.showNewTrackersAfterChangeDate()
            trackersViewModel?.updateVisibleTrackers(isCompleted: true)
        case L10n.Filter.uncompletedTrackers:
            trackersViewModel?.showNewTrackersAfterChangeDate()
            trackersViewModel?.updateVisibleTrackers(isCompleted: false)
        default:
            return
        }
    }
    
    //MARK: TrackerStore Block:
    func addTrackerToStore(model: Tracker) {
        trackerStore?.addTracker(model: model)
    }
    
    func editTrackerFromStore(_ trackerID: UUID) {
        guard let name = trackerName, let color = trackerColor, let emoji = trackerEmoji,
              let schedule = trackerSchedule else { return }
        
        trackerStore?.editTracker(newModel: Tracker(id: trackerID,
                                                               name: name,
                                                               color: color,
                                                               emoji: emoji,
                                                               schedule: schedule))
        resetNewTrackerInfo()
    }
    
    func deleteTrackerFromStore(id: UUID) {
        trackerStore?.deleteTracker(id: id)
        trackerRecordStore?.editRecord(id, newRecordValues: 0)
    }
    
    func getTrackersFromStore(categoryName: String, index: Int) -> Tracker {
        let tracker = trackerStore?.getTracker(categoryName: categoryName, searchedindex: index)
        
        return Tracker(id: tracker?.id ?? UUID(),
                       name: tracker?.name ?? "",
                       color: tracker?.color ?? .clear,
                       emoji: tracker?.emoji ?? "",
                       schedule: tracker?.schedule ?? [])
    }
    
    func updateTrackerStoreController() {
        trackerStore?.updateController()
    }
    
    func pinTracker(_ trackerID: UUID) {
        trackerStore?.pinTracker(trackerID)
    }
    
    func unpinTracker(_ trackerID: UUID) {
        trackerStore?.unpinTracker(trackerID)
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
    
    func editCategory(oldName: String, newName: String) {
        trackerCategoryStore?.editCategory(oldName: oldName, newName: newName)
    }
    
    func removeCategory(_ name: String) {
        trackerCategoryStore?.removeCategory(name)
    }
    
    //MARK: TrackerRecordStore Block:
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
    
    func setNewValueRecords(trackerID: UUID, newRecordValues: Int) {
        trackerRecordStore?.editRecord(trackerID, newRecordValues: newRecordValues)
    }
    
    // MARK: RecordStatistics block:
    func setRecordsToStatisticsService() {
        statisticsService?.provideStatisticsModel(records: completedTrackers)
        
        if completedTrackers?.count == 0 {
            StatisticsServiceHelper().removeAllStatistics()
        }
    }
    
    func getRecordsStatisticsModel() -> TrackersStatistics {
        statisticsService?.statisticsModel ?? TrackersStatistics(completedDays: 0, perfectDays: 0, bestSeries: 0, averageValue: 0)
    }
    
    func clearStatistics() {
        StatisticsServiceHelper().removeAllStatistics()
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
    
    func bindStatisticsViewModel(controller: StatisticsViewModelProtocol) {
        statisticsViewModel = controller
    }
}
