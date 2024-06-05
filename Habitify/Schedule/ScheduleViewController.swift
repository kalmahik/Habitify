//
//  ScheduleScreenViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class ScheduleViewController: UIViewController {

    // MARK: - Private Properties

    private let trackerManager = TrackerManager.shared

    // MARK: - UIViews

    private lazy var doneButton = Button(
        title: NSLocalizedString("doneButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        self.trackerManager.applySchedule()
        self.dismiss(animated: true)
    }

    private lazy var tableView: UITableView = {
        let tableView  = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    private func rowWasTapped(_ indexPath: IndexPath) {
        trackerManager.changeSelectedSchedules(indexPath: indexPath)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

// MARK: - UITableViewDelegate

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowWasTapped(indexPath)
    }
}

// MARK: - UITableViewDataSource

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackerManager.weekDayList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath)
        guard let scheduleCell = cell as? ScheduleCell else { return UITableViewCell() }

        let weekDay = trackerManager.weekDayList[indexPath.row]
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == trackerManager.weekDayList.count - 1
        scheduleCell.setupCell(schedule: weekDay, isFirst: isFirstCell, isLast: isLastCell)
        scheduleCell.delegate = self
        return scheduleCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 75 }
}

extension ScheduleViewController: ScheduleCellDelegate {
    func didTapSwitch(_ cell: ScheduleCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        rowWasTapped(indexPath)
    }
}

// MARK: - applyConstraints && addSubViews

extension ScheduleViewController {
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = NSLocalizedString("scheduleTitle", comment: "")
        view.setupView(tableView)
        view.setupView(doneButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
