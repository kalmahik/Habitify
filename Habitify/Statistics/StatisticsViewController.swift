//
//  StatisticsViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class StatisticsViewController: UIViewController {

    // MARK: - Private Properties

    private let emptyView = EmptyView(emoji: "🥲", title: NSLocalizedString("statisticsEmpty", comment: ""))

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
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
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
