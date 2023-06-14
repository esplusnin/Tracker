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
    var presenter: SchedulePresenterProtocol?
    
    private var scheduleService = ScheduleService()
    
    private let scheduleView = ScheduleView()
    private let dataProviderService = DataProviderService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SchedulePresenter()
        
        setViews()
        setConstraints()
        settingTableView()
        setTarget()
    }
    
    @objc private  func setCurrentScheduleForTracker() {
        let schedule = presenter?.schedule ?? []
        let string = schedule.count == 7 ? "Каждый день" : scheduleService.getScheduleString(schedule)
        
        dataProviderService.selectedScheduleString = string
        dataProviderService.trackerSchedule = schedule
        newTrackerViewController?.reloadTableView()
        presenter?.schedule = []
                
        dismiss(animated: true)
    }
    
    private func setTarget() {
        scheduleView.completeButton.addTarget(self, action: #selector(setCurrentScheduleForTracker), for: .touchUpInside)
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.daysArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.label.text = presenter?.daysArray[indexPath.row]
        
        let numberOfDay = scheduleService.addWeekDayToSchedule(dayName: presenter?.daysArray[indexPath.row] ?? "")
       
        if dataProviderService.isCurrentDayFromScheduleExist(numberOfDay) {
            cell.switcher.isOn = true
            presenter?.schedule.append(numberOfDay)
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
            presenter?.schedule.append(numberOfDay)
        } else {
            guard let index = presenter?.schedule.firstIndex(of: numberOfDay) else { return }
            presenter?.schedule.remove(at: index)
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
