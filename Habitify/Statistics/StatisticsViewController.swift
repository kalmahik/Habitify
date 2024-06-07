//
//  StatisticsViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class StatisticsViewController: UIViewController {

    // MARK: - Private Properties

    private let trackerManager = TrackerManager.shared

    private let emptyView = EmptyView(emoji: "🥲", title: NSLocalizedString("statisticsEmpty", comment: ""))

    private var statisticCell =  StatisticCell()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        let trackersCount = trackerManager.getTrackersCount()
        let recordsCount = trackerManager.getRecordsCount()
        if trackersCount > 0 {
            emptyView.isHidden = true
            statisticCell.isHidden = false
            statisticCell.updateCount(recordsCount, NSLocalizedString("finishedTrackersStats", comment: ""))
        } else {
            emptyView.isHidden = false
            statisticCell.isHidden = true
        }
    }
}

// MARK: - Configure

extension StatisticsViewController {

    private func setupNavBar() {
        navigationItem.title = NSLocalizedString("statisticsTab", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupViews() {
        view.backgroundColor = .mainWhite
        view.setupView(emptyView)
        view.setupView(statisticCell)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: view.heightAnchor),

            statisticCell.heightAnchor.constraint(equalToConstant: 90),
            statisticCell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            statisticCell.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statisticCell.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)

        ])
    }
}
