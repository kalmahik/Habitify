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

    private var viewModel: CategoryViewModel?
    private var categories: [TrackerCategory] = [] // TODO: это не дублирование данных?
    private var observer: NSObjectProtocol?

    private lazy var addCategoryButton = Button(
        title: NSLocalizedString("categoryCreationButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        let categoryCreationVC = CategoryCreationViewController(viewModel: self.viewModel).wrapWithNavigationController()
        self.present(categoryCreationVC, animated: true)
    }

    private lazy var doneButton = Button(
        title: NSLocalizedString("doneButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        self.dismiss(animated: true)
        self.viewModel?.didDoneTapped()
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

    func initialize(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        bind()
        viewModel.loadCategories()
    }

    private func bind() {
        viewModel?.isEmptyStateBinding = { [weak self] isEmpty in
            isEmpty ?
            self?.tableView.setEmptyMessage("💫", NSLocalizedString("categoriesEmpty", comment: "")) :
            self?.tableView.restore()
        }

        viewModel?.categoriesBinding = { [weak self] categories in
            self?.categories = categories
        }
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
        guard let indexPath = viewModel?.getSelectedCategoryIndexPath() else { return }
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRowAt(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
        guard let categoryCell = cell as? CategoryCell else { return UITableViewCell() }
        viewModel?.setupCell(cell: categoryCell, indexPath: indexPath)
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
