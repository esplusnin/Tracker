//
//  FilterViewController.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import UIKit
import SnapKit

final class FilterViewController: UIViewController {
    
    private let filterViews = FilterView()
    private let viewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        filterViews.tableView.register(FilterCell.self, forCellReuseIdentifier: "FilterCell")
        filterViews.tableView.dataSource = self
        filterViews.tableView.delegate = self
        
        setViews()
        setConstraints()
    }
}

// Set Views:
extension FilterViewController {
    private func setViews() {
        view.addSubview(filterViews.titleLabel)
        view.addSubview(filterViews.tableView)
    }
}

// Set Consraints:
extension FilterViewController {
    private func setConstraints() {
        filterViews.titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(27)
        }
        
        filterViews.tableView.snp.makeConstraints { make in
            make.top.equalTo(filterViews.titleLabel.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.availableFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "FilterCell", for: indexPath) as? FilterCell else { return UITableViewCell() }
        
        cell.cellLabel.text = viewModel.availableFilters[indexPath.row]
        if indexPath.row + 1 == viewModel.availableFilters.count {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
        }
        
        return cell
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "FilterCell", for: indexPath) as? FilterCell else { return }
        cell.accessoryType = cell.accessoryType == UITableViewCell.AccessoryType.none ? .checkmark : .none
        
        dismiss(animated: true  )
    }
}
