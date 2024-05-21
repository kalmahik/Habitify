//
//  CategoriesScreenViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class CategoriesViewController: UIViewController {

    // MARK: - Constants

    static let reloadCollection = Notification.Name(rawValue: "reloadCollection")

    // MARK: - Private Properties

    private var observer: NSObjectProtocol?
    private let trackerManager = TrackerManager.shared

    private lazy var addCategoryButton = Button(
        title: NSLocalizedString("categoryCreationButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        self.present(CategoryCreationViewController().wrapWithNavigationController(), animated: true)
    }

    private lazy var doneButton = Button(
        title: NSLocalizedString("doneButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        self.dismiss(animated: true)
        self.trackerManager.updateCategoriesUI()
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
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        return tableView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        addObserver()
        getInitialState()
    }

    private func addObserver() {
        observer = NotificationCenter.default.addObserver(
            forName: CategoriesViewController.reloadCollection,
            object: nil,
            queue: .main
        ) {
            [weak self] _ in self?.tableView.reloadData()
        }
    }

    private func getInitialState() {
        let index = trackerManager.categories.firstIndex { $0.title == trackerManager.newTracker.categoryName }
        guard let index else { return }
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = trackerManager.categories[indexPath.row]
        trackerManager.changeCategory(categoryName: category.title)
    }
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
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

extension CategoriesViewController {
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = NSLocalizedString("categoryTitle", comment: "")
        view.setupView(tableView)
        view.setupView(addCategoryButton)
        view.setupView(doneButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor, constant: -24),

            addCategoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -16),

            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
