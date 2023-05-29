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
    private let trackersView = TrackersView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateFromDatePicker()
        
        setViews()
        setMainCollectionSettings()
        trackersView.searchTextField.delegate = self
    }
    
    func setCellButtonIfTrackerWasCompletedToday(_ id: UUID) -> String {
        var string = "+"
        presenter?.completedTrackers?.forEach({ trackers in
            if trackers.id == id && presenter?.currentDate == trackers.date {
                string = "✓"
            }
        })
        
        return string
    }
                                              
                                              
    
    private func updateCellDayLabel(_ section: Int, row: Int) -> String {
        guard let category = presenter?.categories else { return "" }
        
        let id = category[section].trackerDictionary[row].id
        let string = updateNumberOfCompletedDaysLabel(countAmountOfCompleteDays(id: id))
        
        return string
    }
    
    private func countAmountOfCompleteDays(id: UUID) -> Int {
        var counter = 0
        
        presenter?.completedTrackers?.forEach({ trackerRecord in
            if trackerRecord.id == id {
                counter += 1
            }
        })
        print(counter)
        return counter
    }
    
    private func updateNumberOfCompletedDaysLabel(_ number: Int) -> String {
        var string = "\(number) "
        var array = [number]
        
        switch number {
        case 0:
            string += "Дней"
        case 1:
            string += "День"
        case 2:
            string += "Дня"
        case 3, 4:
            string += "Дня"
        case 5...20:
            string += "Дней"
        case 20...:
            switch array.removeLast() {
            case 1:
                string += "День"
            case 2:
                string += "Дня"
            case 3, 4:
                string += "Дня"
            case 5...9:
                string += "Дней"
            default:
                string += "Дней"
            }
            
        default:
           string = ""
        }
        
        return string
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
    }
    
    func reloadCollectionView() {
        trackersView.trackersCollection.reloadData()
    }
    
    func updateCollectionView() {
        presenter?.currentDate = trackersView.navigationBarDatePicker.date
        presenter?.showNewTrackersAfterChanges()
        
        trackersView.trackersCollection.reloadData()
    }
    
    private func setTargets() {
        trackersView.addTrackerButton.addTarget(self, action: #selector(switchToCreatingTrackerVC), for: .touchUpInside)
        trackersView.navigationBarDatePicker.addTarget(self, action: #selector(setDateFromDatePicker), for: .primaryActionTriggered)
        trackersView.searchTextField.addTarget(self, action: #selector(addCanceletionButton), for: .editingDidBegin)
        trackersView.cancelationButton.addTarget(self, action: #selector(setSearchFieldWithoutCancelationButton), for: .touchUpInside)
    }
    
    @objc private func setDateFromDatePicker() {
        updateCollectionView()
        
        self.dismiss(animated: true)
    }
    
    @objc func switchToCreatingTrackerVC() {
        let viewController = CreatingTrackerViewController()
        viewController.trackerPresenter = presenter
        viewController.trackerViewController = self
        trackersView.searchTextField.endEditing(true)
        
        present(viewController, animated: true)
    }
    
    private func setMainCollectionSettings() {
        trackersView.trackersCollection.register(TrackerCell.self, forCellWithReuseIdentifier: "Cell")
        trackersView.trackersCollection.register(SupplementaryView.self,
                                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                 withReuseIdentifier: "Header")
        
        trackersView.trackersCollection.dataSource = self
        trackersView.trackersCollection.delegate = self
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 167, height: 132)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
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
        let amountOfElement = presenter?.visibleCategories?.count
        trackersView.trackersCollection.alpha = amountOfElement == 0 ? 0 : 1
        return amountOfElement ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let trackerDictionary = presenter?.visibleCategories?[section] else { return 0 }
            
        return trackerDictionary.trackerDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trackersView.trackersCollection.dequeueReusableCell(
            withReuseIdentifier: "Cell", for: indexPath) as? TrackerCell,
              let currentCategory = presenter?.visibleCategories?[indexPath.section],
              let id = presenter?.categories?[indexPath.section].trackerDictionary[indexPath.row].id else { return UICollectionViewCell() }
        
        cell.delegate = self
        
        let currentTracker = currentCategory.trackerDictionary[indexPath.row]
        let cellButtonString = setCellButtonIfTrackerWasCompletedToday(id)
        
        cell.cellView.backgroundColor = currentTracker.color
        cell.trackerLabel.text = currentTracker.name
        cell.emojiLabel.text = currentTracker.emoji
        cell.completeTrackerDayButton.backgroundColor = currentTracker.color
        cell.numberOfDaysLabel.text = updateCellDayLabel(indexPath.section, row: indexPath.row)
        cell.completeTrackerDayButton.setTitle(cellButtonString, for: .normal)
        
        if cellButtonString == "+" {
            cell.completeTrackerDayButton.alpha = 1
        } else {
            cell.completeTrackerDayButton.alpha = 0.5
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
        
        view.headerLabel.text = presenter?.visibleCategories?[indexPath.section].name
        return view
    }
}

extension TrackersViewController: TrackersViewControllerDelegate {
    func addCurrentTrackerToCompletedThisDate(_ cell: TrackerCell, isAddDay: Bool) {
        guard let indexPath = trackersView.trackersCollection.indexPath(for: cell),
              let category = presenter?.visibleCategories,
              let date = presenter?.currentDate else { return }
        
        let section = indexPath.section
        let row = indexPath.row
        
        var newTrackerRecordArray: [TrackerRecord] = []
        
        presenter?.completedTrackers?.forEach({ trackerRecord in
            newTrackerRecordArray.append(trackerRecord)
        })
        
        if isAddDay {
            newTrackerRecordArray.append(TrackerRecord(
                id: category[section].trackerDictionary[row].id,
                date: date))
        } else {
            for trackerRecord in newTrackerRecordArray {
                if trackerRecord.date == presenter?.currentDate {
                newTrackerRecordArray.remove(at: row)
                }
            }
        }
        
        presenter?.completedTrackers = newTrackerRecordArray
        cell.numberOfDaysLabel.text = updateCellDayLabel(section, row: row)
    }
}

//MARK: Setting Views
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

//MARK: Setting Navigation Bar
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
