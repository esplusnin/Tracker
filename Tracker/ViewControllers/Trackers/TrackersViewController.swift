//
//  ViewController.swift
//  Tracker
//
//  Created by Евгений on 18.05.2023.
//

import UIKit
import SnapKit

class TrackersViewController: UIViewController, TrackersViewControllerProtocol {
    
    private let viewModel = TrackersViewModel()
    private let analyticsService = AnalyticsService.instance
    private(set) var trackersView = TrackersView()
    
    private var isReadyToHideFilterButton = true
    private var indexToUpdate: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsService.sentEvent(typeOfEvent: .open, screen: .trackersVC, item: nil)
        trackersView.searchTextField.delegate = self
        bind()
        setDate()
        
        viewModel.showNewTrackersAfterChangeDate()
        
        setViews()
        setMainCollectionSettings()
    }
    
    deinit {
        analyticsService.sentEvent(typeOfEvent: .close, screen: .trackersVC, item: nil)
    }
    
    func bind() {
        viewModel.$visibleTrackers.bind { [weak self] _ in
            guard let self = self else { return }
            self.reloadCollectionView()

            if self.viewModel.visibleTrackers.count == 0 && self.isReadyToHideFilterButton == true {
                self.trackersView.trackersCollection.alpha = 0
                self.setDumbWithNoTrackers()
                self.trackersView.filterButton.removeFromSuperview()
            } else if self.viewModel.visibleTrackers.count == 0 && self.isReadyToHideFilterButton == false {
                self.trackersView.trackersCollection.alpha = 0
                self.setDumbImageViewAfterSearch()
                self.setFilterButton()
            } else if self.viewModel.visibleTrackers.count != 0 && self.isReadyToHideFilterButton == true {
                self.trackersView.trackersCollection.alpha = 1
                self.setFilterButton()
            } else {
                self.trackersView.trackersCollection.alpha = 1
                self.setFilterButton()
            }
            
            viewModel.$isRecordUpdate.bind { [weak self] _ in
                guard let self = self,
                      let indexToUpdate = self.indexToUpdate,
                      let cell = self.trackersView.trackersCollection.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                                     for: indexToUpdate) as? TrackerCell else { return }
                cell.numberOfDaysLabel.reloadInputViews()
            }
            
            viewModel.$isVisibleCategoryEmptyAfterSearch.bind { [weak self] _ in
                guard let self = self else { return }
                self.setDumbImageViewAfterSearch()
            }
            
            viewModel.$isVisibleCategoryEmpty.bind { [weak self] _ in
                guard let self = self else { return }
                self.setDumbWithNoTrackers()
            }
            
            viewModel.$isNeedToChangeDate.bind { [weak self] value in
                guard let self = self else { return }
                
                if value == true {
                    self.trackersView.navigationBarDatePicker.date = Date()
                    self.setDate()
                    self.viewModel.showNewTrackersAfterChangeDate()
                }
            }
        }
    }
    
    func reloadCollectionItem(at indexPath: IndexPath) {
        trackersView.trackersCollection.reloadItems(at: [indexPath])
    }
    
    func reloadCollectionView() {
        trackersView.trackersCollection.reloadData()
    }
    
    func resetTextField() {
        trackersView.searchTextField.endEditing(true)
        trackersView.searchTextField.text = .none
    }
    
    func changeStatusForFilterButton(isHide: Bool) {
        isReadyToHideFilterButton = isHide ? true : false
    }
    
    private func isPerfectDayToday() {
        var counter = 0
        for trackerCell in trackersView.trackersCollection.visibleCells {
            guard let trackerCell = trackerCell as? TrackerCell else { return }
            if trackerCell.additionalTrackerInfo?.isCompleteToday == true {
                counter += 1
            }
        }

        if counter == trackersView.trackersCollection.visibleCells.count {
            viewModel.changeCountOfPerfectDays(isAdd: true)
        } else {
            viewModel.changeCountOfPerfectDays(isAdd: false)
        }
    }
    
    private func setDate() {
        let date = DateService().convertDateWithoutTimes(date: trackersView.navigationBarDatePicker.date)
        viewModel.currentDate = date
    }
    
    private func setTargets() {
        trackersView.addTrackerButton.addTarget(
            self, action: #selector(switchToCreatingTrackerVC), for: .touchUpInside)
        trackersView.filterButton.addTarget(
            self, action: #selector(switchToFilterVC), for: .touchUpInside)
        trackersView.navigationBarDatePicker.addTarget(
            self, action: #selector(setDateFromDatePicker), for: .primaryActionTriggered)
        trackersView.searchTextField.addTarget(
            self, action: #selector(updateVisibleTrackersAfterSearch), for: [.editingChanged, .editingDidEnd])
        trackersView.searchTextField.addTarget(
            self, action: #selector(addCanceletionButton), for: .editingDidBegin)
        trackersView.cancelationButton.addTarget(
            self, action: #selector(setSearchFieldWithoutCancelationButton), for: .touchUpInside)
    }
    
    @objc private func switchToFilterVC() {
        let viewController = FilterViewController()
        viewController.trackersViewController = self
        
        resetTextField()
        analyticsService.sentEvent(typeOfEvent: .click, screen: .trackersVC, item: .filter)
        
        present(viewController, animated: true)
    }
    
    @objc private func switchToCreatingTrackerVC() {
        let viewController = CreatingTrackerViewController()
        viewController.trackerViewController = self
        trackersView.searchTextField.endEditing(true)
        changeStatusForFilterButton(isHide: true)
        
        analyticsService.sentEvent(typeOfEvent: .click, screen: .trackersVC, item: .addTrack)
        
        present(viewController, animated: true)
    }
    
    @objc private func updateVisibleTrackersAfterSearch() {
        if trackersView.searchTextField.hasText {
            changeStatusForFilterButton(isHide: true)
            
            guard let searchFieldText = trackersView.searchTextField.text else { return }
            
            viewModel.updateVisibleTrackersAfterSearch(filledName: searchFieldText)
        }
    }
    
    @objc private func setDateFromDatePicker() {
        changeStatusForFilterButton(isHide: true)

        setDate()
        resetTextField()
        viewModel.showNewTrackersAfterChangeDate()
        
        self.dismiss(animated: true)
    }
}

// MARK: TrackersCollectionViewCellDelegate
extension TrackersViewController: TrackersCollectionViewCellDelegate {
    func addCurrentTrackerToCompletedThisDate(_ cell: TrackerCell, isAddDay: Bool) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell),
              let date = viewModel.currentDate else { return }
        

        let tracker = viewModel.visibleTrackers[indexPath.section].trackerDictionary[indexPath.row]
        indexToUpdate = indexPath
        viewModel.changeStatusTrackerRecord(model: TrackerRecord(id: tracker.id,
                                                                        date: date), isAddDay: isAddDay)
        viewModel.fillAdditionalInfo(id: tracker.id)
        analyticsService.sentEvent(typeOfEvent: .click, screen: .trackersVC, item: .track)
        
        cell.additionalTrackerInfo = viewModel.additionTrackerInfo
        
        isPerfectDayToday()
    }
    
    func pinTracker(from cell: TrackerCell) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell) else { return }
        let trackerID = viewModel.visibleTrackers[indexPath.section].trackerDictionary[indexPath.row].id

        viewModel.pinTracker(trackerID)
    }
    
    func unpinTracker(from cell: TrackerCell) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell) else { return }
        let trackerID = viewModel.visibleTrackers[indexPath.section].trackerDictionary[indexPath.row].id

        viewModel.unpinTracker(trackerID)
    }
    
    func editTracker(from cell: TrackerCell) {
        guard let trackerModel = cell.trackerModel,
              var additionalTrackerInfo = cell.additionalTrackerInfo,
              let indexPath = trackersView.trackersCollection.indexPath(for: cell) else { return }
        
        let viewController = NewTrackerViewController()
        
        additionalTrackerInfo.categoryName = viewModel.visibleTrackers[indexPath.section].name
        viewController.kindOfTracker = .habit
        viewController.setupEditingVC(trackerInfo: trackerModel, additionalTrackerInfo: additionalTrackerInfo)
        analyticsService.sentEvent(typeOfEvent: .click, screen: .trackersVC, item: .edit)
        
        present(viewController, animated: true)
    }
    
    func deleteTracker(from cell: TrackerCell) {
        changeStatusForFilterButton(isHide: true)

        AlertService().showAlert(event: .removeTracker,
                                 controller: self) { [weak self] in
            guard let self = self,
                  let indexPath = self.trackersView.trackersCollection.indexPath(for: cell) else { return }
            
            let visibleCategories = self.viewModel.visibleTrackers
            let tracker = visibleCategories[indexPath.section].trackerDictionary[indexPath.row]
            
            self.analyticsService.sentEvent(typeOfEvent: .click, screen: .trackersVC, item: .delete)
            self.viewModel.deleteTracker(id: tracker.id)
            
        }
    }
}

// MARK: UITextFieldDelegate
extension TrackersViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 && string.isEmpty || !textField.hasText || range.length == 1 && textField.text?.count == 0 {
            viewModel.showNewTrackersAfterChangeDate()
        }
        
        return true
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidht = trackersView.trackersCollection.frame.width / 2
        let cellWidht = availableWidht - 24
        
        return CGSize(width: cellWidht, height: cellWidht * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                             at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

// MARK: UICollectionViewDataSource
extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.visibleTrackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.visibleTrackers[section].trackerDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trackersView.trackersCollection.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath) as? TrackerCell else { return UICollectionViewCell() }
        
        let visibleCategories = viewModel.visibleTrackers
        let tracker = visibleCategories[indexPath.section].trackerDictionary[indexPath.row]
        let sectionName = visibleCategories[indexPath.section].name
        
        viewModel.fillAdditionalInfo(id: tracker.id)
        let additionalInfo = viewModel.additionTrackerInfo
        
        cell.trackerModel = tracker
        cell.additionalTrackerInfo = additionalInfo
        cell.delegate = self
        
        cell.isTrackerPinned = sectionName == L10n.TrackerVC.pinned ? true : false
        cell.pinSingImageView.isHidden = sectionName == L10n.TrackerVC.pinned ? false : true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let visibleCategories = viewModel.visibleTrackers
        
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "Header"
        default:
            id = ""
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? SupplementaryView else { return UICollectionReusableView() }
        
        view.headerLabel.text = visibleCategories[indexPath.section].name
        
        return view
    }
}

// MARK: Main settings of CollectionView
extension TrackersViewController {
    private func setMainCollectionSettings() {
        trackersView.trackersCollection.register(TrackerCell.self, forCellWithReuseIdentifier: "Cell")
        trackersView.trackersCollection.register(SupplementaryView.self,
                                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                 withReuseIdentifier: "Header")
        
        trackersView.trackersCollection.dataSource = self
        trackersView.trackersCollection.delegate = self
    }
}

// MARK: Setting Views
extension TrackersViewController {
    private func setViews() {
        view.backgroundColor = .whiteDay
        
        view.addSubview(trackersView.emptyTrackersImageView)
        view.addSubview(trackersView.emptyTrackersLabel)
        view.addSubview(trackersView.searchTextField)
        view.addSubview(trackersView.trackersCollection)
        
        setNavBar()
        setConstraints()
        setTargets()
    }
    
    @objc private func addCanceletionButton() {
        view.addSubview(trackersView.cancelationButton)
        
        trackersView.searchTextField.snp.removeConstraints()
        
        trackersView.cancelationButton.snp.makeConstraints { make in
            make.width.equalTo(83)
            make.height.equalTo(36)
            make.top.equalToSuperview().inset(150)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(trackersView.searchTextField)
        }
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalToSuperview().inset(150)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(trackersView.cancelationButton.snp.leading).inset(-5)
        }
    }
    
    @objc private func setSearchFieldWithoutCancelationButton() {
        resetTextField()
        let visibleCategories = viewModel.visibleTrackers
        trackersView.cancelationButton.removeFromSuperview()
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        if visibleCategories.count == 0 {
            setDumbWithNoTrackers()
        }
        
        viewModel.showNewTrackersAfterChangeDate()
    }
    
    private func setDumbImageViewAfterSearch() {
        trackersView.emptyTrackersImageView.image = Resources.Images.searchedTrackersIsEmpty
        trackersView.emptyTrackersLabel.text = L10n.TrackerVC.nothingSearched
    }
    
    private func setDumbWithNoTrackers() {
        trackersView.emptyTrackersImageView.image = Resources.Images.trackersIsEmpty
        trackersView.emptyTrackersLabel.text = L10n.TrackerVC.EmptyState.label
    }
    
    private func setFilterButton() {
        view.addSubview(trackersView.filterButton)
        
        trackersView.filterButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(130)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(60)
        }
    }
}

// MARK: Setting Navigation Bar
extension TrackersViewController {
    private func setNavBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.prefersLargeTitles = true
        
        navigationBar.addSubview(trackersView.addTrackerButton)
        navigationBar.addSubview(trackersView.navigationBarTitleLabel)
        navigationBar.addSubview(trackersView.navigationBarDatePicker)
    }
}

// MARK: Setting Layout
extension TrackersViewController {
    private func setConstraints() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        trackersView.emptyTrackersImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        trackersView.emptyTrackersLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(trackersView.emptyTrackersImageView.snp.bottom).offset(8)
        }
        
        trackersView.addTrackerButton.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.width.equalTo(19)
            make.leading.equalTo(navigationBar.snp.leading).inset(18)
            make.top.lessThanOrEqualTo(navigationBar.snp.top).inset(20)
        }
        
        trackersView.navigationBarTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(navigationBar.snp.leading).inset(16)
            make.top.equalTo(trackersView.addTrackerButton.snp.bottom).inset(-13)
        }
        
        trackersView.navigationBarDatePicker.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.trailing.equalTo(navigationBar).inset(16)
            make.centerY.equalTo(trackersView.navigationBarTitleLabel.snp.centerY)
        }
        
        setSearchFieldWithoutCancelationButton()
        
        trackersView.trackersCollection.snp.makeConstraints { make in
            make.top.equalTo(trackersView.searchTextField.snp.bottom).inset(-14)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
