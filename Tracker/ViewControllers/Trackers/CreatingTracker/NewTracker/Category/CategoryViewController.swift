//
//  CategoryViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    private let categoryView = CategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        setTargets()
    }
    
    @objc private func switchToNewCategoryVC() {
        let viewController = NewCategoryViewController()
        
        present(viewController,animated: true)
    }
    
    private func setTargets() {
        categoryView.createCategoryButton.addTarget(self,
                                                    action: #selector(switchToNewCategoryVC),
                                                    for: .touchUpInside)
    }
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(categoryView.titleLabel)
        view.addSubview(categoryView.emptyCategoryImageView)
        view.addSubview(categoryView.emptyCategoryLabel)
        view.addSubview(categoryView.createCategoryButton)
    }
    
    private func setConstraints() {
        categoryView.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.centerX.equalToSuperview()
        }
        
        categoryView.emptyCategoryImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        categoryView.emptyCategoryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(categoryView.emptyCategoryImageView.snp.bottom).offset(8)
        }
        
        categoryView.createCategoryButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
