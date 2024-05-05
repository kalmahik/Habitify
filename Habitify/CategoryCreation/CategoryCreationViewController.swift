//
//  StatisticsViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class CategoryCreationViewController: UIViewController {

    // MARK: - Private Properties

    private lazy var categoryNameInput: UITextField = {
        let textField = TextField()
        textField.placeholder = "Введите название категории"
        textField.backgroundColor = .mainLigthGray
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        return textField
    }()

    private lazy var doneButton = Button(title: "Готово", color: .mainBlack, style: .normal) {
        guard let name = self.categoryNameInput.text else { return }
        self.createNewCategory(with: name)
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
    }

    // MARK: - Private Functions

    private func createNewCategory(with name: String) {
    }

}

// MARK: - Configure View

extension CategoryCreationViewController {

    private func setupNavBar() {
        navigationItem.title = "Новая категория"
    }

    private func setupViews() {
        view.backgroundColor = .mainWhite
        view.setupView(categoryNameInput)
        view.setupView(doneButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryNameInput.heightAnchor.constraint(equalToConstant: 75),
            categoryNameInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            categoryNameInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryNameInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
