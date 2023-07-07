//
//  FilterViewController.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import UIKit
import SnapKit

final class FilterViewController: UIViewController {
    
    private(set) var filterView = FilterView()
    private let viewModel = FilterViewModel()
    private let analyticsService = AnalyticsService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsService.sentEvent(typeOfEvent: .open, screen: .filterVC, item: nil)
        
        view.backgroundColor = .whiteDay
        
        filterView.tableView.register(FilterCell.self, forCellReuseIdentifier: "FilterCell")
        filterView.tableView.dataSource = self
        filterView.tableView.delegate = self
        
        setViews()
        setConstraints()
    }
    
    deinit {
        analyticsService.sentEvent(typeOfEvent: .close, screen: .filterVC, item: nil)
    }
}

// Set Views:
extension FilterViewController {
    private func setViews() {
        view.addSubview(filterView.titleLabel)
        view.addSubview(filterView.tableView)
    }
}

// Set Consraints:
extension FilterViewController {
    private func setConstraints() {
        filterView.titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(27)
        }
        
        filterView.tableView.snp.makeConstraints { make in
            make.top.equalTo(filterView.titleLabel.snp.bottom).inset(-24)
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
        
        cell.accessoryType = cell.cellLabel.text == viewModel.getCurrentFilter() ? .checkmark : .none
        
        return cell
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterCell else { return }
        
        cell.accessoryType = cell.accessoryType == UITableViewCell.AccessoryType.none ? .checkmark : .none
        viewModel.setCurrentFilter(selected: cell.cellLabel.text ?? "")
        
        dismiss(animated: true)
    }
}
