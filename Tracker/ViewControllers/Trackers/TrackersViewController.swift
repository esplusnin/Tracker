//
//  ViewController.swift
//  Tracker
//
//  Created by Евгений on 18.05.2023.
//

import UIKit
import SnapKit

class TrackersViewController: UIViewController {
    
    var presenter = TrackersViewPresenter()
    private let trackersView = TrackersView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainCollectionSettings()
        trackersView.searchTextField.delegate = self
        
        setViews()
    }
    
    private func setTargets() {
        trackersView.addTrackerButton.addTarget(self, action: #selector(switchToCreatingTrackerVC), for: .touchUpInside)
        trackersView.navigationBarDatePicker.addTarget(self, action: #selector(setDateFromDatePicker), for: .primaryActionTriggered)
    }
    
    @objc private func setDateFromDatePicker() {
        presenter.currentDate = trackersView.navigationBarDatePicker.date
        self.dismiss(animated: true)
    }
    
    @objc func switchToCreatingTrackerVC() {
        let viewController = CreatingTrackerViewController()
        
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trackersView.trackersCollection.dequeueReusableCell(
            withReuseIdentifier: "Cell", for: indexPath) as? TrackerCell else { return UICollectionViewCell() }
        cell.trackerLabel.text = "Полить цветы"
        cell.cellView.backgroundColor = cell.colorSectionArray[indexPath.row]
        cell.emojiLabel.text = presenter.emojiArray[indexPath.row]
        cell.completeTrackerDayButton.backgroundColor = cell.colorSectionArray[indexPath.row]
        
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
        
        view.headerLabel.text = "Домашний уют"
        return view
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
        
        trackersView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        trackersView.trackersCollection.snp.makeConstraints { make in
            make.top.equalTo(trackersView.searchTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
