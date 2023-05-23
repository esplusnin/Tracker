//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit

final class NewHabitViewController: UIViewController {
    private let newHabit = NewHabitView()
    private let presenter = NewHabitPresenter()
    
    var emojiArray = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    var colorSectionArray = [
        UIColor.colorSelection1, UIColor.colorSelection2,UIColor.colorSelection3, UIColor.colorSelection4,
        UIColor.colorSelection5, UIColor.colorSelection6, UIColor.colorSelection7, UIColor.colorSelection8,
        UIColor.colorSelection9, UIColor.colorSelection10, UIColor.colorSelection11, UIColor.colorSelection12,
        UIColor.colorSelection13, UIColor.colorSelection14, UIColor.colorSelection15, UIColor.colorSelection16,
        UIColor.colorSelection17, UIColor.colorSelection18,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newHabit.colorCollectionView.register(NewHabitCollectionCell.self,
                                              forCellWithReuseIdentifier: "CollectionCell")
        newHabit.colorCollectionView.register(NewHabitSupplementaryView.self,
                                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: "Header")
        
        newHabit.colorCollectionView.dataSource = self
        newHabit.colorCollectionView.delegate = self
        
        setViews()
        setConstraints()
        setTableViewMainSetting()
    }
    
    private func switchToCategoryVC() {
        let viewController = CategoryViewController()
        
        present(viewController,animated: true)
    }
    
    private func switchToScheduleVC() {
        let viewController = ScheduleViewController()
        
        present(viewController,animated: true)
    }
    
    private func setTableViewMainSetting() {
        newHabit.tableView.register(NewHabitCell.self, forCellReuseIdentifier: "Cell")
        newHabit.tableView.dataSource = self
        newHabit.tableView.delegate = self
    }
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(newHabit.titleLabel)
        view.addSubview(newHabit.textField)
        view.addSubview(newHabit.tableView)
        view.addSubview(newHabit.colorCollectionView)
        view.addSubview(newHabit.cancelButton)
        view.addSubview(newHabit.createButton)
    }
    
    private func setConstraints() {
        newHabit.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(13)
        }
        
        newHabit.textField.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.top.equalTo(newHabit.titleLabel.snp.bottom).inset(-38)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        newHabit.tableView.snp.makeConstraints { make in
            make.height.equalTo(149)
            make.top.equalTo(newHabit.textField.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        newHabit.colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(newHabit.tableView.snp.bottom).inset(-32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
        }
        
        newHabit.cancelButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(newHabit.colorCollectionView.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.bottom.equalToSuperview().inset(34)
        }
        
        newHabit.createButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(newHabit.colorCollectionView.snp.bottom)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(34)
        }
    }
}

extension NewHabitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) as? NewHabitCell else { return UITableViewCell() }
        
        cell.label.text = presenter.buttonsTitleForTableView[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension NewHabitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            switchToCategoryVC()
        case IndexPath(row: 1, section: 0):
            switchToScheduleVC()
        default:
            return
        }
    }
}

extension NewHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? emojiArray.count : colorSectionArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CollectionCell",
            for: indexPath) as? NewHabitCollectionCell else { return UICollectionViewCell() }
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
            for: indexPath) as? NewHabitSupplementaryView else { return UICollectionReusableView() }
        
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

extension NewHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 32, height: 38)
        case 1:
            return CGSize(width: 40, height: 40)
        default:
            return CGSize(width: 32, height: 38)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 29, bottom: 47, right: 29)
        case 1:
            return UIEdgeInsets(top: 0, left: 29, bottom: 47, right: 29)
        default:
            return UIEdgeInsets(top: 0, left: 29, bottom: 47, right: 29)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        14
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

