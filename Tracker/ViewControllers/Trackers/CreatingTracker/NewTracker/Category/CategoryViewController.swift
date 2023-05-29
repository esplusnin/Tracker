//
//  CategoryViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class CategoryViewController: UIViewController, CategoryViewControllerProtocol {
    
    private let categoryView = CategoryView()
    var trackerPresenter: TrackersViewPresenterProtocol?
    var newTrackerViewController: NewTrackerViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
     
        categoryView.tableView.delegate = self
        categoryView.tableView.dataSource = self
        
        categoryView.tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        
        setViews()
        setConstraints()
        setTargets()
    }
    
    func reloadTableView() {
        categoryView.tableView.reloadData()
    }
    
    @objc private func switchToNewCategoryVC() {
        let viewController = NewCategoryViewController()
        viewController.trackerPresenter = trackerPresenter
        viewController.categoryViewController = self
        
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
        view.addSubview(categoryView.tableView)
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
        
        categoryView.tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.titleLabel.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(categoryView.createCategoryButton).inset(-30)
        }
        
        
        categoryView.createCategoryButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else { return }
        cell.accessoryType = cell.accessoryType == UITableViewCell.AccessoryType.none ? .checkmark : .none
        cell.selectionStyle = .none
        newTrackerViewController?.selectedCategory = cell.label.text
        newTrackerViewController?.reloadTableView()
        
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackerPresenter?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell,
              let trakersCategory = trackerPresenter?.categories else { return UITableViewCell() }
        
        cell.label.text = trakersCategory[indexPath.row].name
        cell.accessoryType = cell.label.text == newTrackerViewController?.selectedCategory ? .checkmark : .none
        if indexPath.row + 1 == trackerPresenter?.categories?.count {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}
