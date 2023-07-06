//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

enum KindOfTrackers {
    case habit
    case unregularEvent
}

final class NewTrackerViewController: UIViewController, NewTrackerViewControllerProtocol {
    
    var creatingTrackerViewController: CreatingTrackerViewControllerProtocol?
    var kindOfTracker: KindOfTrackers?
    
    private(set) var newTrackerView = NewTrackerView()
    private let viewModel = NewTrackerViewModel()

    // For Editing VC:
    private var trackerID: UUID?
    private var countOfDays = 0 {
        didSet {
            newTrackerView.countOfCompleteDaysLabel.text = LocalizableConstants.TrackerVC.countOfCompletedDays(countOfDays: countOfDays)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        newTrackerView.textField.delegate = self
        
        setViews()
        setTitle()
        setTableView()
        setConstraints()
        setTableViewMainSettings()
        setCollectionViewMainSetting()
        setTargets()
        bind()
    }
    
    func bind() {
        viewModel.$isReadyToCreateNewTracker.bind { [weak self] value in
            guard let self = self else { return }
            if value == true {
                self.newTrackerView.createButton.controlState(isLock: false)
            } else {
                self.newTrackerView.createButton.controlState(isLock: true)
            }
        }
    }
    
    func reloadTableView() {
        newTrackerView.tableView.reloadData()
    }
    
    private func setTargets() {
        newTrackerView.cancelButton.addTarget(self, action: #selector(dismissNewTrackerVC), for: .touchUpInside)
        newTrackerView.createButton.addTarget(self, action: #selector(createNewTracker), for: .touchUpInside)
        newTrackerView.leftStepperButton.addTarget(self, action: #selector(decreaseCountOfDays), for: .touchUpInside)
        newTrackerView.rightStepperButton.addTarget(self, action: #selector(increaseCountOfDays), for: .touchUpInside)
    }
    
    private func setTitle() {
        newTrackerView.titleLabel.text = kindOfTracker == .habit ? LocalizableConstants.NewTrackerVC.habitTitle : LocalizableConstants.NewTrackerVC.unregularTitle
    }
    
    private func switchToCategoryVC() {
        let viewController = CategoryViewController()
        viewController.newTrackerViewController = self
        
        present(viewController,animated: true)
    }
    
    private func switchToScheduleVC() {
        let viewController = ScheduleViewController()
        viewController.newTrackerViewController = self
        
        present(viewController,animated: true)
    }
    
    private func setTextFieldWarning(_ countOfTextFieldLetter: Int?) {
        guard let countOfTextFieldLetter = countOfTextFieldLetter else { return }
        if countOfTextFieldLetter >= 38 {
            view.addSubview(newTrackerView.warningTextFieldLimitationLabel)
            newTrackerView.createButton.controlState(isLock: true)
            
            newTrackerView.warningTextFieldLimitationLabel.snp.makeConstraints { make in
                make.top.equalTo(newTrackerView.textField.snp.bottom).inset(-8)
                make.centerX.equalToSuperview()
            }
            
            newTrackerView.tableView.snp.makeConstraints { make in
                make.top.equalTo(newTrackerView.textField.snp.bottom).inset(-66)
            }
        } else {
            newTrackerView.warningTextFieldLimitationLabel.removeFromSuperview()
            newTrackerView.tableView.snp.makeConstraints { make in
                make.top.equalTo(newTrackerView.textField.snp.bottom).inset(-24)
            }
        }
    }
    
    private func setTableView() {
        view.addSubview(newTrackerView.tableView)
        
        newTrackerView.tableView.snp.makeConstraints { make in
            if kindOfTracker == .habit {
                make.height.equalTo(149)
            } else {
                make.height.equalTo(75)
                newTrackerView.tableView.separatorStyle = .none
            }
            
            make.height.equalTo(149)
            make.top.greaterThanOrEqualTo(newTrackerView.textField.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func createNewTracker() {
        viewModel.createNewTracker()
        viewModel.resetTrackerInfoAfterCreate()
        dismissNewTrackerVC()
    }
    
    @objc private func editTracker() {
        guard let trackerID = trackerID else { return }
        
        viewModel.editTracker(trackerID)
        viewModel.changeRecord(trackerID: trackerID, newRecordValues: countOfDays)
        dismiss(animated: true)
    }
    
    @objc private func increaseCountOfDays() {
        countOfDays += 1
    }
    
    @objc private func decreaseCountOfDays() {
        if countOfDays > 0 {
            countOfDays -= 1
        }
    }
    
    @objc private func dismissNewTrackerVC() {
        dismiss(animated: true)
        creatingTrackerViewController?.backToTrackerViewController()
    }
}

// MARK: UITextFieldDelegate
extension NewTrackerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setTextFieldWarning(textField.text?.count)
        let name = textField.text == "" ? nil : textField.text
        guard let name = name else { return }
        
        if name.count < 38 {
            viewModel.setTrackerName(name: name)
        }
    }
}

// MARK: UITableViewDataSource
extension NewTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch kindOfTracker {
        case .habit:
            return 2
        case .unregularEvent:
            return 1
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as? NewTrackerCell else { return UITableViewCell() }
        
        cell.categoryLabel.text = viewModel.buttonsTitleForTableView[indexPath.row]
        cell.accessoryType = .disclosureIndicator
      
        switch indexPath.row {
        case 0:
             if let name = viewModel.getSelectedCategoryName() {
                cell.categoryLabel.snp.removeConstraints()
                cell.setViewsWithCategory(name)
            } else {
                cell.setViewsWithoutCategory()
            }
        case 1:
            if let schedule = viewModel.getSelectedScheduleString() {
                cell.categoryLabel.snp.removeConstraints()
                cell.setViewsWithCategory(schedule)
            } else {
                cell.setViewsWithoutCategory()
            }
        default:
            cell.setViewsWithoutCategory()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

// MARK: UITableViewDelegate
extension NewTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            switchToCategoryVC()
        case IndexPath(row: 1, section: 0):
            switchToScheduleVC()
        default:
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension NewTrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emojiArray = viewModel.emojiArray.count
        
        return section == 0 ? emojiArray : viewModel.colorSectionArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CollectionCell",
            for: indexPath) as? NewTrackerCollectionCell else { return UICollectionViewCell() }
        
        let emojiArray = viewModel.emojiArray
        
        switch indexPath.section {
        case 0:
            cell.setFirstSection()
            cell.emojiLabel.text = emojiArray[indexPath.row]
        case 1:
            cell.setSecondSection()
            cell.colorSectionImageView.backgroundColor = viewModel.colorSectionArray[indexPath.row]
        default:
            return UICollectionViewCell()
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
            return UICollectionReusableView()
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? NewTrackerSupplementaryView else { return UICollectionReusableView() }
        
        switch indexPath.section {
        case 0:
            view.headerLabel.text = LocalizableConstants.NewTrackerVC.emoji
        case 1:
            view.headerLabel.text = LocalizableConstants.NewTrackerVC.collectionViewColor
        default:
            view.headerLabel.text = ""
        }
        
        return view
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension NewTrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidht = newTrackerView.collectionView.frame.width / 6
        let cellWidght = availableWidht - 15
        
        return CGSize(width: cellWidght, height: cellWidght)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 25, bottom: 45, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewTrackerCollectionCell else { return }
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .lightGray
            viewModel.setTrackerEmoji(emoji: cell.emojiLabel.text ?? "")
        case 1:
            let color = cell.colorSectionImageView.backgroundColor?.withAlphaComponent(0.3)
            cell.layer.borderWidth = 3
            cell.layer.borderColor = color?.cgColor
            viewModel.setTrackerColor(color: cell.colorSectionImageView.backgroundColor ?? UIColor())
        default:
            cell.backgroundColor = .lightGray
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewTrackerCollectionCell else { return }
        
        cell.backgroundColor = .none
        
        viewModel.resetTrackerInfoAfterDeselect(section: indexPath.section)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.indexPathsForSelectedItems?.filter({ $0.section == indexPath.section }).forEach({
            collectionView.deselectItem(at: $0, animated: true)
        })
        
        return true
    }
}

// MARK: Main Settings of TableView
extension NewTrackerViewController {
    private func setTableViewMainSettings() {
        newTrackerView.tableView.register(NewTrackerCell.self, forCellReuseIdentifier: "Cell")
        newTrackerView.tableView.dataSource = self
        newTrackerView.tableView.delegate = self
    }
}

// MARK: Main Settings of CollectionView
extension NewTrackerViewController {
    private func setCollectionViewMainSetting() {
        newTrackerView.collectionView.register(NewTrackerCollectionCell.self,
                                               forCellWithReuseIdentifier: "CollectionCell")
        newTrackerView.collectionView.register(NewTrackerSupplementaryView.self,
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                               withReuseIdentifier: "Header")
        
        newTrackerView.collectionView.dataSource = self
        newTrackerView.collectionView.delegate = self
    }
}

// MARK: Set EditingVC:
extension NewTrackerViewController {
    func setupEditingVC(trackerInfo: Tracker, additionalTrackerInfo: AdditionTrackerInfo) {
        setupEditingTrackerMenu(trackerInfo: trackerInfo, additionalTrackerInfo: additionalTrackerInfo)
        setupCurrentTrackerInfo(trackerInfo: trackerInfo, additionatlInfo: additionalTrackerInfo)
        setupTargets()
    }
    private func setupEditingTrackerMenu(trackerInfo: Tracker, additionalTrackerInfo: AdditionTrackerInfo) {
        viewModel.presetTrackerInfo(trackerInfo: trackerInfo, additionalTrackerInfo: additionalTrackerInfo)
        
        view.addSubview(newTrackerView.countOfCompleteDaysLabel)
        view.addSubview(newTrackerView.leftStepperButton)
        view.addSubview(newTrackerView.rightStepperButton)
        
        newTrackerView.countOfCompleteDaysLabel.snp.makeConstraints { make in
            make.top.equalTo(newTrackerView.titleLabel).inset(35)
            make.top.equalTo(newTrackerView.titleLabel).inset(35)
            make.centerX.equalToSuperview()
        }
        
        newTrackerView.leftStepperButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(newTrackerView.countOfCompleteDaysLabel.snp.centerY)
            make.trailing.equalTo(newTrackerView.countOfCompleteDaysLabel.snp.leading).inset(-20)
        }
        
        newTrackerView.rightStepperButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerY.equalTo(newTrackerView.countOfCompleteDaysLabel.snp.centerY)
            make.leading.equalTo(newTrackerView.countOfCompleteDaysLabel.snp.trailing).inset(-20)
        }
        
        newTrackerView.textField.snp.removeConstraints()
        newTrackerView.textField.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.top.equalTo(newTrackerView.countOfCompleteDaysLabel.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        setupCurrentTrackerInfo(trackerInfo: trackerInfo, additionatlInfo: additionalTrackerInfo)
    }
    
    private func setupCurrentTrackerInfo(trackerInfo: Tracker, additionatlInfo: AdditionTrackerInfo) {
//        let indexes = findIndexesOfEmojiAndColors(emoji: trackerInfo.emoji, color: trackerInfo.color)
        
        viewModel.setTrackerName(name: trackerInfo.name)
        viewModel.setTrackerEmoji(emoji: trackerInfo.emoji)
        viewModel.setTrackerColor(color: trackerInfo.color)
        
        newTrackerView.titleLabel.text = LocalizableConstants.EditingHabit.title
        newTrackerView.createButton.setTitle(LocalizableConstants.EditingHabit.saveButton, for: .normal)
        newTrackerView.textField.text = trackerInfo.name
        newTrackerView.countOfCompleteDaysLabel.text = LocalizableConstants.TrackerVC.countOfCompletedDays(countOfDays: additionatlInfo.countOfDays)
        
        countOfDays = additionatlInfo.countOfDays
        trackerID = trackerInfo.id
    }
    
    private func findIndexesOfEmojiAndColors(emoji: String, color: UIColor) -> (Int, Int) {
        let colorService = UIColorMarshallingService()
        let trackerColorHex = colorService.hexStringFromColor(color: color)
        
        guard let emojiIndex = viewModel.emojiArray.firstIndex(where: { $0 == emoji }),
              let colorIndex = viewModel.colorSectionArray.firstIndex(
                where: { colorService.hexStringFromColor(color: $0) == trackerColorHex }) else { return (0, 0) }
        
        return (emojiIndex, colorIndex)
    }
    
    private func setupTargets() {
        newTrackerView.createButton.removeTarget(self, action: #selector(createNewTracker), for: .touchUpInside)
        newTrackerView.createButton.addTarget(self, action: #selector(editTracker), for: .touchUpInside)
    }
}

// MARK: Setting views:
extension NewTrackerViewController {
    private func setViews() {
        view.backgroundColor = .whiteDay
        
        view.addSubview(newTrackerView.scrollView)
        
        newTrackerView.scrollView.addSubview(newTrackerView.titleLabel)
        newTrackerView.scrollView.addSubview(newTrackerView.textField)
        newTrackerView.scrollView.addSubview(newTrackerView.collectionView)
        newTrackerView.scrollView.addSubview(newTrackerView.cancelButton)
        newTrackerView.scrollView.addSubview(newTrackerView.createButton)
    }
}

// MARK: Setting constraints:
extension NewTrackerViewController {
    private func setConstraints() {
        newTrackerView.scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        newTrackerView.titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(27)
        }
        
        newTrackerView.textField.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.top.equalTo(newTrackerView.titleLabel.snp.bottom).inset(-38)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        newTrackerView.collectionView.snp.makeConstraints { make in
            make.width.equalTo(newTrackerView.scrollView)
            make.top.equalTo(newTrackerView.tableView.snp.bottom).inset(-32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        
        newTrackerView.cancelButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(newTrackerView.collectionView.snp.bottom).inset(-30)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.bottom.equalToSuperview().inset(34)
        }
        
        newTrackerView.createButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(newTrackerView.collectionView.snp.bottom).inset(-30)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(34)
        }
    }
}
