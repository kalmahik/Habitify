//
//  StatisticsViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class CategoryCreationViewController: UIViewController {

    private var viewModel: CategoryViewModel?

    // MARK: - Private Properties

    private lazy var categoryNameInput: UITextField = {
        let textField = TextField()
        textField.placeholder = NSLocalizedString("categoryNamePlaceholder", comment: "")
        textField.backgroundColor = .mainLigthGray
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.delegate = self
        return textField
    }()

    private lazy var doneButton = Button(
        title: NSLocalizedString("doneButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        // weak self?
        guard let name = self.categoryNameInput.text else { return }
        self.viewModel?.createCategory(categoryName: name)
        self.dismiss(animated: true)
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
    }

    init(viewModel: CategoryViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure View

extension CategoryCreationViewController {

    private func setupNavBar() {
        navigationItem.title =  NSLocalizedString("categoryCreationTitle", comment: "")
    }

    private func setupViews() {
        view.backgroundColor = .mainWhite
        doneButton.isEnabled = false
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

extension CategoryCreationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }

    @objc private func textFieldDidChange(textField: UITextField) {
        if let text = textField.text {
            let isEmpty = text.trim().isEmpty
            doneButton.isEnabled = !isEmpty
        }
    }
}
