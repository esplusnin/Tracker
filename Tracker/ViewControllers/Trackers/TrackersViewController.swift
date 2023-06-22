//
//  ViewController.swift
//  Tracker
//
//  Created by Евгений on 18.05.2023.
//

import UIKit
import SnapKit

class TrackersViewController: UIViewController, TrackersViewControllerProtocol {
    
    var trackerViewModel = TrackersViewModel()
    private let trackersView = TrackersView()
    private var indexToUpdate: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackersView.searchTextField.delegate = self
        
        bind()
        setDate()
        
        trackerViewModel.showNewTrackersAfterChangeDate()
        
        setViews()
        setMainCollectionSettings()
        
        DataProviderService.instance.bindTrackersViewModel(controller: trackerViewModel)
        trackerViewModel.setVisibleTrackersFromProvider()
        
    }
    
    func bind() {
        trackerViewModel.$visibleTrackers.bind { [weak self] _ in
            guard let self = self else { return }
            self.reloadCollectionView()
            self.trackersView.trackersCollection.alpha = self.trackerViewModel.visibleTrackers.count == 0 ? 0 : 1
        }
        
        trackerViewModel.$isRecordUpdate.bind { [weak self] _ in
            guard let self = self,
                  let indexToUpdate = indexToUpdate,
                  let cell = trackersView.trackersCollection.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                                 for: indexToUpdate) as? TrackerCell else { return }
            cell.numberOfDaysLabel.reloadInputViews()
        }
        
        trackerViewModel.$isVisibleCategoryEmptyAfterSearch.bind { [weak self] value in
            guard let self = self else { return }
            self.setDumbImageViewAfterSearch()
        }
        
        trackerViewModel.$isVisibleCategoryEmpty.bind { [weak self] value in
            guard let self = self else { return }
            self.setDumbWithNoTrackers()
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
    
    private func setDate() {
        let date = DateService().convertDateWithoutTimes(date: trackersView.navigationBarDatePicker.date)
        trackerViewModel.currentDate = date
    }
    
    private func setTargets() {
        trackersView.addTrackerButton.addTarget(
            self, action: #selector(switchToCreatingTrackerVC), for: .touchUpInside)
        trackersView.navigationBarDatePicker.addTarget(
            self, action: #selector(setDateFromDatePicker), for: .primaryActionTriggered)
        trackersView.searchTextField.addTarget(
            self, action: #selector(updateVisibleTrackersAfterSearch), for: [.editingChanged, .editingDidEnd])
        trackersView.searchTextField.addTarget(
            self, action: #selector(addCanceletionButton), for: .editingDidBegin)
        trackersView.cancelationButton.addTarget(
            self, action: #selector(setSearchFieldWithoutCancelationButton), for: .touchUpInside)
    }
    
    private func setDumbImageViewAfterSearch() {
        trackersView.emptyTrackersImageView.image = Resources.Images.searchedTrackersIsEmpty
        trackersView.emptyTrackersLabel.text = "Ничего не найдено"
    }
    
    private func setDumbWithNoTrackers() {
        trackersView.emptyTrackersImageView.image = Resources.Images.trackersIsEmpty
        trackersView.emptyTrackersLabel.text = "Что будем отслеживать?"
    }
    
    @objc private func switchToCreatingTrackerVC() {
        let viewController = CreatingTrackerViewController()
        viewController.trackerViewController = self
        trackersView.searchTextField.endEditing(true)
        
        present(viewController, animated: true)
    }
    
    @objc private func updateVisibleTrackersAfterSearch() {
        guard let searchFieldText = trackersView.searchTextField.text else { return }
        
        trackerViewModel.updateVisibleTrackersAfterSearch(filledName: searchFieldText)
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
        let visibleCategories = trackerViewModel.visibleTrackers
        trackersView.cancelationButton.removeFromSuperview()
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        if visibleCategories.count == 0 {
            setDumbWithNoTrackers()
        }
        
        trackerViewModel.showNewTrackersAfterChangeDate()
    }
    
    @objc private func setDateFromDatePicker() {
        setDate()
        resetTextField()
        trackerViewModel.showNewTrackersAfterChangeDate()
        reloadCollectionView()
        
        self.dismiss(animated: true)
    }
}

extension TrackersViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 && string.isEmpty || !textField.hasText {
            trackerViewModel.showNewTrackersAfterChangeDate()
        }
        
        return true
    }
}

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


extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        trackerViewModel.visibleTrackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        trackerViewModel.visibleTrackers[section].trackerDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trackersView.trackersCollection.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath) as? TrackerCell else { return UICollectionViewCell() }
        
        let visibleCategories = trackerViewModel.visibleTrackers
        let tracker = visibleCategories[indexPath.section].trackerDictionary[indexPath.row]
        
        trackerViewModel.fillAdditionalInfo(id: tracker.id)
        let additionalInfo = trackerViewModel.additionTrackerInfo
        
        cell.trackerModel = tracker
        cell.additionalTrackerInfo = additionalInfo
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let visibleCategories = trackerViewModel.visibleTrackers
        
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

extension TrackersViewController: TrackersCollectionViewCellDelegate {
    func addCurrentTrackerToCompletedThisDate(_ cell: TrackerCell, isAddDay: Bool) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell),
              let date = trackerViewModel.currentDate else { return }
        
        let tracker = trackerViewModel.visibleTrackers[indexPath.section].trackerDictionary[indexPath.row]
        indexToUpdate = indexPath
        trackerViewModel.changeStatusTrackerRecord(model: TrackerRecord(id: tracker.id,
                                                                        date: date), isAddDay: isAddDay)
        trackerViewModel.fillAdditionalInfo(id: tracker.id)
        cell.additionalTrackerInfo = trackerViewModel.additionTrackerInfo
        
    }
    
    func editTracker(from cell: TrackerCell) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell) else { return }
        
        let visibleCategories = trackerViewModel.visibleTrackers
        let tracker = visibleCategories[indexPath.section].trackerDictionary[indexPath.row]
        
        trackerViewModel.editTracker(id: tracker.id)
    }
    
    func deleteTracker(from cell: TrackerCell) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell) else { return }
        
        let visibleCategories = trackerViewModel.visibleTrackers
        let tracker = visibleCategories[indexPath.section].trackerDictionary[indexPath.row]
        
        trackerViewModel.deleteTracker(id: tracker.id)
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
        view.backgroundColor = .white
        
        view.addSubview(trackersView.emptyTrackersImageView)
        view.addSubview(trackersView.emptyTrackersLabel)
        view.addSubview(trackersView.searchTextField)
        view.addSubview(trackersView.trackersCollection)
        
        setNavBar()
        setConstraints()
        setTargets()
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
