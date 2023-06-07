//
//  ViewController.swift
//  Tracker
//
//  Created by Евгений on 18.05.2023.
//

import UIKit
import SnapKit

class TrackersViewController: UIViewController, TrackersViewControllerProtocol {
    
    var presenter: TrackersViewPresenterProtocol?
    
    let dataProviderService = DataProviderService.instance
    private let trackersView = TrackersView()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataProviderService.trackerStore = TrackerStore()
        dataProviderService.trackerCategoryStore = TrackerCategoryStore()
        dataProviderService.trackersViewController = self
        
        dataProviderService.inizializeVisibleCategories()
        
        trackersView.searchTextField.delegate = self
        
        setDateFromDatePicker()
        
        setViews()
        setMainCollectionSettings()
    }
    
    func reloadCOll() {
        trackersView.trackersCollection.reloadData()
        resetTextFieldAndDate()
    }
    
//    func updateCollectionView(_ updates: CollectionStoreUpdates) {
//        resetTextFieldAndDate()
//        
//        print("зашли в updateCollectionView")
//        trackersView.trackersCollection.performBatchUpdates {
//            let insertedIndex = updates.insertedIndex.map { IndexPath(row: $0, section: 0) }
//            let deletedIndex = updates.deletedIndex.map { IndexPath(row: $0, section: 0) }
//            
//            trackersView.trackersCollection.insertItems(at: insertedIndex)
//            trackersView.trackersCollection.deleteItems(at: deletedIndex)
//        }
//    }
    
    func resetTextFieldAndDate() {
        trackersView.searchTextField.endEditing(true)
        trackersView.searchTextField.text = .none
        presenter?.currentDate = trackersView.navigationBarDatePicker.date
    }
    
    @objc func switchToCreatingTrackerVC() {
        let viewController = CreatingTrackerViewController()
        viewController.trackerPresenter = presenter
        viewController.trackerViewController = self
        trackersView.searchTextField.endEditing(true)
        
        present(viewController, animated: true)
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
        
        trackersView.trackersCollection.alpha = 0
    }
    
    @objc private func updateVisibleTrackersAfterSearch() {
        guard let searchFieldText = trackersView.searchTextField.text,
              let categories = dataProviderService.visibleCategories else { return }
        
        let newCategories = presenter?.searchTrackerByName(categories: categories, filledName: searchFieldText)
        
        if newCategories?.count == 0 {
            setDumbImageViewAfterSearch()
        }
        
        dataProviderService.visibleCategories = newCategories
        trackersView.trackersCollection.reloadData()
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
        trackersView.searchTextField.text = .none
        trackersView.cancelationButton.removeFromSuperview()
        trackersView.searchTextField.endEditing(true)
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        if dataProviderService.visibleCategories?.count == 0 {
            trackersView.emptyTrackersLabel.text = "Что будем отслеживать?"
            trackersView.emptyTrackersImageView.image = Resources.Images.trackersIsEmpty
        }
        
        resetTextFieldAndDate()
    }
    
    @objc private func setDateFromDatePicker() {
        resetTextFieldAndDate()
        
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
//        let amountOfElement = dataProviderService.getNumberOfCategories()
        let amountOfElement = dataProviderService.visibleCategories?.count

        trackersView.trackersCollection.alpha = amountOfElement == 0 ? 0 : 1

        return amountOfElement ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        dataProviderService.visibleCategories?[section].trackerDictionary.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trackersView.trackersCollection.dequeueReusableCell(
            withReuseIdentifier: "Cell", for: indexPath) as? TrackerCell,
              let presenter = presenter else { return UICollectionViewCell() }
        
//        let categoryName = dataProviderService.getCategoryNameFromStore(at: indexPath.section)
//        let tracker = dataProviderService.getTrackersFromStore(categoryName: categoryName, index: indexPath.row)
        let tracker = dataProviderService.visibleCategories?[indexPath.section].trackerDictionary[indexPath.row]
        
        presenter.setupParticularCell(model: tracker!, cell: cell)
        
        cell.delegate = self

        if presenter.checkCurrentDateIsFuture() {
            cell.unlockCompleteButton()
        } else {
            cell.lockCompleteButton()
            cell.completeTrackerDayButton.backgroundColor = .colorSelection1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
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
        
        view.headerLabel.text = dataProviderService.getCategoryNameFromStore(at: indexPath.section)
        
        return view
    }
}

extension TrackersViewController: TrackersCollectionViewCellDelegate {
    func addCurrentTrackerToCompletedThisDate(_ cell: TrackerCell, isAddDay: Bool) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell),
              let date = presenter?.currentDate else { return }
        
        let section = indexPath.section
        let row = indexPath.row
        
        let newCompletedTrackers = presenter?.updateCompletedTrackersArray(storage: dataProviderService,
                                                                           isAddDay: isAddDay,
                                                                           date: date,
                                                                           section,
                                                                           row)
        
        dataProviderService.completedTrackers = newCompletedTrackers
        cell.numberOfDaysLabel.text = presenter?.updateCellDayLabel(dataProviderService, section, row: row)
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
