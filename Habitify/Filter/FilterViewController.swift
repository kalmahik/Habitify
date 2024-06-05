//
//  FilterViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class FilterViewController: UIViewController {

    // MARK: - Private Properties

    private let trackerManager = TrackerManager.shared

    // MARK: - UIViews

    private lazy var tableView: UITableView = {
        let tableView  = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        tableView.separatorStyle = .none

        let indexPath = trackerManager.getIndexPathOfFilter()
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        return tableView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - UITableViewDelegate

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trackerManager.applyFilter(indexPath: indexPath)
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackerManager.filters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath)
        guard let filterCell = cell as? FilterCell else { return UITableViewCell() }

        let filter = trackerManager.filters[indexPath.row]
        let title = NSLocalizedString(filter.rawValue, comment: "")
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == trackerManager.filters.count - 1
        filterCell.setupCell(label: title, isFirst: isFirstCell, isLast: isLastCell)
        return filterCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 75 }
}

// MARK: - applyConstraints && addSubViews

extension FilterViewController {
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = NSLocalizedString("filters", comment: "")
        view.setupView(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
