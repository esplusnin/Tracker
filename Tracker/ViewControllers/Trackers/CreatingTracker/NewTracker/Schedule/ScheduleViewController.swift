//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit
import SnapKit


final class ScheduleViewController: UIViewController {
    
    private let scheduleView = ScheduleView()
    private let presenter = ScheduleViewPresenter()
    var newTrackerController: NewTrackerViewControllerProtocol?
    var scheduleService = ScheduleService()
    var schedule: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        settingTableView()
        setTarget()
    }
    
    @objc func setCurrentScheduleForTracker() {
        let string = schedule.count == 7 ? "Каждый день" : scheduleService.getScheduleString(schedule)
        
        newTrackerController?.selectedScheduleString = string
        newTrackerController?.trackerSchedule = schedule
        newTrackerController?.reloadTableView()
                
        dismiss(animated: true)
    }
    
    private func setTarget() {
        scheduleView.completeButton.addTarget(self, action: #selector(setCurrentScheduleForTracker), for: .touchUpInside)
    }
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(scheduleView.titleLabel)
        view.addSubview(scheduleView.scheduleTableView)
        view.addSubview(scheduleView.completeButton)
    }
    
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
    
    private func settingTableView() {
        scheduleView.scheduleTableView.dataSource = self
        scheduleView.scheduleTableView.delegate = self
        
        scheduleView.scheduleTableView.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.daysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.label.text = presenter.daysArray[indexPath.row]
        
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
            schedule.append(numberOfDay)
        } else {
            guard let index = schedule.firstIndex(of: numberOfDay) else { return }
            schedule.remove(at: index)
        }
    }
}
