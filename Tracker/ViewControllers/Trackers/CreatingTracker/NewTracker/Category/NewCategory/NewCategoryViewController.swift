//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Евгений on 24.05.2023.
//

import UIKit
import SnapKit

final class NewCategoryViewController: UIViewController {
    
//    var trackerPresenter: TrackersViewPresenterProtocol?
    var categoryViewController: CategoryViewControllerProtocol?
    
    private let newCategory = NewCategoryView()
    private let trackerStorage = DataProviderService.instance
    private let trackerCategoryStore = TrackerCategoryStore.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCategory.textField.delegate = self
        
        setViews()
        setConstraints()
        setTarget()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setTarget() {
        newCategory.completeButton.addTarget(self, action: #selector(createNewCategory), for: .touchUpInside)
    }
    
    @objc private func createNewCategory() {
        guard let name = newCategory.textField.text else { return }
        trackerCategoryStore.addCategory(name: name)
        
        dismiss(animated: true)
        categoryViewController?.reloadTableView()
    }
}

extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newCategory.completeButton.backgroundColor = textField.text?.count != 0 ? .blackDay : .gray
    }
}

// MARK: Setting views:
extension NewCategoryViewController {
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(newCategory.titleLabel)
        view.addSubview(newCategory.textField)
        view.addSubview(newCategory.completeButton)
    }
}

// MARK: Setting constraints:
extension NewCategoryViewController {
    private func setConstraints() {
        newCategory.titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
        }
        
        newCategory.textField.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.top.equalTo(newCategory.titleLabel.snp.bottom).inset(-38)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        newCategory.completeButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
