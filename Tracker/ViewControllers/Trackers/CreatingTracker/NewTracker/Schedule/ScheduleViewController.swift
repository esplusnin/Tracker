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
    
    private let scheduleView = ScheduleView()
    private let scheduleViewModel = ScheduleViewModel()
    private var scheduleService = ScheduleService()
    private let dataProviderService = DataProviderService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProviderService.bindScheduleViewModel(controller: scheduleViewModel)
        
        setViews()
        setConstraints()
        settingTableView()
        setTarget()
        bind()
    }
    
    private func bind() {
        scheduleViewModel.$isReadyToCloseSchedule.bind { [weak self] value in
            guard let self = self else { return }
            
            if value == true {
                newTrackerViewController?.reloadTableView()
                dismiss(animated: true)
            }
        }
    }
    
    private func setTarget() {
        scheduleView.completeButton.addTarget(self, action: #selector(setCurrentScheduleForTracker), for: .touchUpInside)
    }
    
    @objc private  func setCurrentScheduleForTracker() {
        scheduleViewModel.setSchedule()
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scheduleViewModel.daysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.viewModel = scheduleViewModel.daysArray[indexPath.row]
        
        let numberOfDay = scheduleViewModel.returnNumberOfDay(from: indexPath)
       
        if scheduleViewModel.isCurrentDayExistInSchedule(day: numberOfDay) {
            cell.switcher.isOn = true
            scheduleViewModel.addDayToSchedule(day: numberOfDay)
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
            scheduleViewModel.addDayToSchedule(day: numberOfDay)
        } else {
            guard let index = scheduleViewModel.schedule.firstIndex(of: numberOfDay) else { return }
            scheduleViewModel.removeAddFromSchedule(index: index)
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
        view.backgroundColor = .white
        
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
