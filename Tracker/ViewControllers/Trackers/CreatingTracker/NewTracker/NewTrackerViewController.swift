//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class NewTrackerViewController: UIViewController, NewTrackerViewControllerProtocol {
    
    var presenter: NewTrackerViewPresenterProtocol?
    var trackerPresenter: TrackersViewPresenterProtocol?
    var creatingTrackerViewController: CreatingTrackerViewControllerProtocol?
    var kindOfTracker: KindOfTrackers?
    
    private let newTracker = NewTrackerView()

    var selectedCategoryString: String?
    var selectedScheduleString: String?
    
    // Preparing for create new tracker:
    var trackerName: String?
    var trackerColor: UIColor?
    var trackerEmoji: String?
    var trackerSchedule: [Int]?
    
    var colorSectionArray: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4,
        .colorSelection5, .colorSelection6, .colorSelection7, .colorSelection8,
        .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16,
        .colorSelection17, .colorSelection18,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTracker.textField.delegate = self
        presenter = NewTrackerViewPresenter()
        presenter?.view = self
        
        setViews()
        setTitle()
        setTableView()
        setConstraints()
        setTableViewMainSettings()
        setCollectionViewMainSetting()
        setTargets()
    }
   
    func reloadTableView() {
        newTracker.tableView.reloadData()
    }
    
    func unlockCreateButton() {
        newTracker.createButton.isEnabled = true
        newTracker.createButton.backgroundColor = .blackDay
    }
    
    func lockCreateButton() {
        newTracker.createButton.isEnabled = false
        newTracker.createButton.backgroundColor = .gray
    }
    
    private func setTargets() {
        newTracker.cancelButton.addTarget(self, action: #selector(dismissNewTrackerVC), for: .touchUpInside)
        newTracker.createButton.addTarget(self, action: #selector(createNewTracker), for: .touchUpInside)
    }
    
    private func setTitle() {
        newTracker.titleLabel.text = kindOfTracker == .habit ? "Новая привычка" : "Новое нерегулярное событие"
    }
    
    private func switchToCategoryVC() {
        let viewController = CategoryViewController()
        viewController.trackerPresenter = trackerPresenter
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
            view.addSubview(newTracker.warningTextFieldLimitationLabel)
            lockCreateButton()
            
            newTracker.warningTextFieldLimitationLabel.snp.makeConstraints { make in
                make.top.equalTo(newTracker.textField.snp.bottom).inset(-8)
                make.centerX.equalToSuperview()
            }
            
            newTracker.tableView.snp.makeConstraints { make in
                make.top.equalTo(newTracker.textField.snp.bottom).inset(-66)
            }
            
        } else {
            newTracker.warningTextFieldLimitationLabel.removeFromSuperview()
            unlockCreateButton()
            
            newTracker.tableView.snp.makeConstraints { make in
                make.top.equalTo(newTracker.textField.snp.bottom).inset(-24)
            }
        }
    }
    
    private func setTableView() {
        view.addSubview(newTracker.tableView)
        
        newTracker.tableView.snp.makeConstraints { make in
            if kindOfTracker == .habit {
                make.height.equalTo(149)
            } else {
                make.height.equalTo(75)
                newTracker.tableView.separatorStyle = .none
            }
            
            make.height.equalTo(149)
            make.top.greaterThanOrEqualTo(newTracker.textField.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc func createNewTracker() {
        let newCategoryArray = presenter?.createNewTracker()

        trackerPresenter?.categories = newCategoryArray
        
        dismissNewTrackerVC()
        creatingTrackerViewController?.backToTrackerViewController()
    }

    @objc private func dismissNewTrackerVC() {
        dismiss(animated: true)
    }
}

extension NewTrackerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setTextFieldWarning(textField.text?.count)
        trackerName = textField.text
        presenter?.checkCreateButtonToUnclock()
    }
}

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
        
        cell.categoryLabel.text = presenter?.buttonsTitleForTableView[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            if let name = selectedCategoryString {
                cell.categoryLabel.snp.removeConstraints()
                cell.setViewsWithCategory(name)
            } else {
                cell.setViewsWithoutCategory()
            }
        case 1:
            if let schedule = selectedScheduleString {
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

extension NewTrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emojiArray = trackerPresenter?.emojiArray.count ?? 0
        return section == 0 ? emojiArray : colorSectionArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell",
                                                            for: indexPath) as? NewTrackerCollectionCell,
              let emojiArray = trackerPresenter?.emojiArray else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.setFirstSection()
            cell.emojiLabel.text = emojiArray[indexPath.row]
        case 1:
            cell.setSecondSection()
            cell.colorSectionImageView.backgroundColor = colorSectionArray[indexPath.row]
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
            view.headerLabel.text = "Emoji"
        case 1:
            view.headerLabel.text = "Цвет"
        default:
            view.headerLabel.text = ""
        }
        
        return view
    }
}

extension NewTrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter?.calculationSizeForItemAtCollectionView(section: indexPath.section) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 29, bottom: 47, right: 29)
        case 1:
            return UIEdgeInsets(top: 0, left: 25, bottom: 47, right: 25)
        default:
            return UIEdgeInsets(top: 0, left: 29, bottom: 47, right: 29)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        presenter?.calculationMinimumInteritemSpacingForSectionAt(section: section) ?? CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        presenter?.calculationMinimumLineSpacingForSectionAt(section: section) ?? CGFloat(0)
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
            trackerEmoji = cell.emojiLabel.text
        case 1:
            cell.layer.borderWidth = 2
            cell.layer.borderColor = cell.colorSectionImageView.backgroundColor?.cgColor
            trackerColor = cell.colorSectionImageView.backgroundColor
        default:
            cell.backgroundColor = .lightGray
        }
        presenter?.checkCreateButtonToUnclock()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewTrackerCollectionCell else { return }
        
        presenter?.checkCreateButtonToUnclock()

        cell.backgroundColor = .none
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
        newTracker.tableView.register(NewTrackerCell.self, forCellReuseIdentifier: "Cell")
        newTracker.tableView.dataSource = self
        newTracker.tableView.delegate = self
    }
}
    
// MARK: Main Settings of CollectionView
extension NewTrackerViewController {
    private func setCollectionViewMainSetting() {
        newTracker.colorCollectionView.register(NewTrackerCollectionCell.self,
                                                forCellWithReuseIdentifier: "CollectionCell")
        newTracker.colorCollectionView.register(NewTrackerSupplementaryView.self,
                                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: "Header")
        
        newTracker.colorCollectionView.dataSource = self
        newTracker.colorCollectionView.delegate = self
    }
}

// MARK: Setting views:
extension NewTrackerViewController {
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(newTracker.scrollView)
        
        newTracker.scrollView.addSubview(newTracker.titleLabel)
        newTracker.scrollView.addSubview(newTracker.textField)
        newTracker.scrollView.addSubview(newTracker.colorCollectionView)
        newTracker.scrollView.addSubview(newTracker.cancelButton)
        newTracker.scrollView.addSubview(newTracker.createButton)
    }
}

// MARK: Setting constraints:
extension NewTrackerViewController {
    private func setConstraints() {
        newTracker.scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        newTracker.titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(27)
        }
        
        newTracker.textField.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.top.equalTo(newTracker.titleLabel.snp.bottom).inset(-38)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        newTracker.colorCollectionView.snp.makeConstraints { make in
            make.width.equalTo(newTracker.scrollView)
            make.top.equalTo(newTracker.tableView.snp.bottom).inset(-32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        
        newTracker.cancelButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(newTracker.colorCollectionView.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.bottom.equalToSuperview().inset(34)
        }
        
        newTracker.createButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(newTracker.colorCollectionView.snp.bottom)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(34)
        }
    }
}
