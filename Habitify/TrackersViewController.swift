//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let emptyView = EmptyTrackersView()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        setupConstraints()
    }
    
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationController?.navigationBar.prefersLargeTitles = true
        view.setupView(emptyView)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Трекеры"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        add.tintColor = .mainBlack
        navigationItem.leftBarButtonItem = add
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    // MARK: - Private Functions
    
    @objc private func addTapped() {
        let viewController = TrackerTypeViewController().wrapWithNavigationController()
        present(viewController, animated: true)
    }
}
