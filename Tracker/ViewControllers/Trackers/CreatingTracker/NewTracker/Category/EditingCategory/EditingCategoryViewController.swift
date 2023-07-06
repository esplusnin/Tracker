//
//  EditingCategoryViewController.swift
//  Tracker
//
//  Created by Евгений on 04.07.2023.
//

import UIKit
import SnapKit

final class EditingCategoryViewController: UIViewController {
    
    private let editingCategoryView = EditingCategoryView()
    private let viewModel = EditingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editingCategoryView.textField.delegate = self
        setViews()
        setConstraints()
        setTarget()
        editingCategoryView.completeButton.controlState(isLock: true)
        
        editingCategoryView.textField.becomeFirstResponder()
    }
    
    init(categoryName: String) {
        super.init(nibName: nil, bundle: nil)
        self.setTextFieldPlaceholder(categoryName)
        self.viewModel.setOldCategoryName(categoryName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextFieldPlaceholder(_ name: String) {
        editingCategoryView.textField.placeholder = name
    }
    
    private func setTarget() {
        editingCategoryView.completeButton.addTarget(self, action: #selector(editCategory), for: .touchUpInside)
    }
    
    @objc private func editCategory() {
        guard let categoryName = editingCategoryView.textField.text else { return }
        
        viewModel.editCategory(newCategoryName: categoryName)
        dismiss(animated: true)
    }
}

extension EditingCategoryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text?.count != 0 ? editingCategoryView.completeButton.controlState(isLock: false) : editingCategoryView.completeButton.controlState(isLock: true)
    }
}

// Set Views:
extension EditingCategoryViewController {
    private func setViews() {
        view.backgroundColor = .white

        view.addSubview(editingCategoryView.titleLabel)
        view.addSubview(editingCategoryView.textField)
        view.addSubview(editingCategoryView.completeButton)
    }
}

// Set Constraints:
extension EditingCategoryViewController {
    private func setConstraints() {
        editingCategoryView.titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
        }
        
        editingCategoryView.textField.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.top.equalTo(editingCategoryView.titleLabel.snp.bottom).inset(-38)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        editingCategoryView.completeButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
