//
//  CategoriesScreenViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class CategoriesScreenViewController: UIViewController {

    // MARK: - Private Properties

    private let trackerManager = TrackerManager.shared

    private lazy var addCategoryButton = Button(
        title: NSLocalizedString("categoryCreationButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        self.present(CategoryCreationViewController().wrapWithNavigationController(), animated: true)
    }

    private lazy var tableView: UITableView = {
        let tableView  = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
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
        if trackerManager.categories.isEmpty {
            tableView.setEmptyMessage("💫", NSLocalizedString("categoriesEmpty", comment: ""))
        } else {
            tableView.restore()
        }
        return trackerManager.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
        guard let categoryCell = cell as? CategoryCell else { return UITableViewCell() }
        let category = trackerManager.categories[indexPath.row]
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == trackerManager.categories.count - 1
        categoryCell.setupCell(category: category, isFirst: isFirstCell, isLast: isLastCell)
        return categoryCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 75 }
}

// MARK: - applyConstraints && addSubViews

extension CategoriesScreenViewController {
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = NSLocalizedString("categoryTitle", comment: "")
        view.setupView(tableView)
        view.setupView(addCategoryButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor, constant: -24),

            addCategoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
