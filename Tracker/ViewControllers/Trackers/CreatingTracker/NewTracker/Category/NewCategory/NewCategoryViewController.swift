//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Евгений on 24.05.2023.
//

import UIKit
import SnapKit

final class NewCategoryViewController: UIViewController {
    
    var categoryViewController: CategoryViewControllerProtocol?
    
    private let newCategory = NewCategoryView()
    private let dataProviderService = DataProviderService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCategory.textField.becomeFirstResponder()
        newCategory.textField.delegate = self
        
        setViews()
        setConstraints()
        setTarget()
        
        controlStateCompleteButton(newCategory.textField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setTarget() {
        newCategory.completeButton.addTarget(self, action: #selector(createNewCategory), for: .touchUpInside)
    }
    
    private func controlStateCompleteButton(_ textField: UITextField) {
        if textField.text?.count != 0 {
            newCategory.completeButton.controlState(isLock: false)
        } else {
            newCategory.completeButton.controlState(isLock: true)
        }
    }
    
    @objc private func createNewCategory() {
        guard let name = newCategory.textField.text else { return }
        dataProviderService.addCategoryToStore(name: name)
        
        dismiss(animated: true)
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
        controlStateCompleteButton(textField)
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
