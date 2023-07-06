//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit


final class ScheduleViewController: UIViewController {

    var newTrackerViewController: NewTrackerViewControllerProtocol?
    
    private(set) var scheduleView = ScheduleView()
    private let viewModel = ScheduleViewModel()
    private var scheduleService = ScheduleService()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setViews()
        setConstraints()
        settingTableView()
        setTarget()
        scheduleView.completeButton.controlState(isLock: true)
        bind()
    }
    
    private func bind() {
        viewModel.$isReadyToCloseScheduleVC.bind { [weak self] value in
            guard let self = self else { return }
            
            if value == true {
                newTrackerViewController?.reloadTableView()
                dismiss(animated: true)
            }
        }
        
        viewModel.$isReadyToUnlockCreateButton.bind { [weak self] value in
            guard let self = self else { return }
            
            if value == true {
                scheduleView.completeButton.controlState(isLock: false)
            } else {
                scheduleView.completeButton.controlState(isLock: true)
            }
        }
    }
    
    private func setTarget() {
        scheduleView.completeButton.addTarget(self, action: #selector(setCurrentScheduleForTracker), for: .touchUpInside)
    }
    
    @objc private  func setCurrentScheduleForTracker() {
        viewModel.setSchedule()
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.daysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.viewModel = viewModel.daysArray[indexPath.row]
        
        let numberOfDay = viewModel.returnNumberOfDay(from: indexPath)
       
        if viewModel.isCurrentDayExistInSchedule(day: numberOfDay) {
            cell.switcher.isOn = true
            viewModel.addDayToSchedule(day: numberOfDay)
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension ScheduleViewController: UITableViewDelegate {
    
}

extension ScheduleViewController: ScheduleViewControllerDelegate {
    func controlScheduleDay(_ cell: ScheduleCell) {
        guard let dayName = cell.label.text else { return }
        
        let numberOfDay = scheduleService.addWeekDayToSchedule(dayName: dayName)
        
        if cell.switcher.isOn {
            viewModel.addDayToSchedule(day: numberOfDay)
        } else {
            guard let index = viewModel.schedule.firstIndex(of: numberOfDay) else { return }
            viewModel.removeAddFromSchedule(index: index)
        }
    }
}

// MARK: Main Settings of TableView:
extension ScheduleViewController {
    private func settingTableView() {
        scheduleView.scheduleTableView.dataSource = self
        scheduleView.scheduleTableView.delegate = self
        
        scheduleView.scheduleTableView.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
    }
}

// MARK: Setting views:
extension ScheduleViewController {
    private func setViews() {
        view.backgroundColor = .whiteDay
        
        view.addSubview(scheduleView.titleLabel)
        view.addSubview(scheduleView.scheduleTableView)
        view.addSubview(scheduleView.completeButton)
    }
}

// MARK: Setting constraints:
extension ScheduleViewController {
    private func setConstraints() {
        scheduleView.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.centerX.equalToSuperview()
        }
        
        scheduleView.scheduleTableView.snp.makeConstraints { make in
            make.height.equalTo(524)
            make.top.equalTo(scheduleView.titleLabel.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        scheduleView.completeButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(scheduleView.scheduleTableView.snp.bottom).inset(-39)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
