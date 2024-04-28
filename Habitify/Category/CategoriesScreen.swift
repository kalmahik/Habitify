//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class CategoriesScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let trackerManager = TrackerManager.shared
    
    private lazy var addCategoryButton = Button(title: "Добавить категорию", color: .mainBlack, style: .normal) {
        self.present(CategoryCreationViewController().wrapWithNavigationController(), animated: true)
    }
    
    private lazy var emptyView = EmptyView(emoji: "💫", title: "Привычки и события можно объединить по смыслу")
    
    private lazy var tableView: UITableView = {
        let tableView  = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.contentInset = Insets.horizontalInset
        tableView.dataSource = self
        tableView.delegate = self
        tableView.scrollIndicatorInsets = tableView.contentInset
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

extension CategoriesScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource

extension CategoriesScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackerManager.trackers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
        guard let categoryCell = cell as? CategoryCell else { return UITableViewCell() }
        let category = trackerManager.trackers[indexPath.row]
//        let dateLabel = photo.createdAt?.dateString ?? ""
//        imageListCell.selectionStyle = .none
//        imageListCell.backgroundColor = .ypBlack
//        categoryCell.delegate = self
        categoryCell.setupCell(category: category)
        return categoryCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 75 }
}

// MARK: - applyConstraints && addSubViews

extension CategoriesScreenViewController {
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = "Категория"
        view.setupView(tableView)
//        view.setupView(emptyView)
        view.setupView(addCategoryButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            addCategoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}
