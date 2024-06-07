//
//  CollectionHeader.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class CollectionHeader: UICollectionViewCell {

    // MARK: - Constants

    static let identifier = "CollectionHeader"

    // MARK: - Private Properties

    private let trackerManager = TrackerManager.shared

    // MARK: - Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - UIViews

    private lazy var strikeTitle = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var trackerNameInput: UITextField = {
        let textField = TextField()
        textField.placeholder = NSLocalizedString("trackerNamePlaceholder", comment: "")
        textField.backgroundColor = .mainBackground
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()

    private lazy var categoryButton = ArrowButton(
        title: NSLocalizedString("categoryButton", comment: ""),
        subtitle: trackerManager.tracker.categoryName
    ) {
        let categoriesM = CategoryModel()
        let categoriesVM = CategoryViewModel(for: categoriesM)
        let categoriesVC = CategoriesViewController(viewModel: categoriesVM)
        let viewController = categoriesVC.wrapWithNavigationController()
        self.parentViewController?.present(viewController, animated: true)
    }

    private lazy var scheduleButton = ArrowButton(
        title: NSLocalizedString("scheduleButton", comment: ""),
        subtitle: trackerManager.tracker.schedule
    ) {
        let viewController = ScheduleViewController().wrapWithNavigationController()
        self.parentViewController?.present(viewController, animated: true)
    }

    private let titleView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 0
        return stack
    }()

    private let wrapperView: UIStackView =  {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .mainBackground
        return view
    }()

    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGray
        return view
    }()

    // MARK: - Public Methods

    func setupCell() {
        let tracker = trackerManager.tracker
        scheduleButton.updateSubtitle(subtitle: tracker.schedule)
        categoryButton.updateSubtitle(subtitle: tracker.categoryName)
        trackerNameInput.text = tracker.name
        if let trackerId = trackerManager.tracker.id {
            let trackerCount = trackerManager.getTrackerCount(trackerId: trackerId)
            let strikeTitleText = String.localizedStringWithFormat(NSLocalizedString("numberOffDays", comment: ""), trackerCount)
            strikeTitle.text = strikeTitleText
        }
    }
}

// MARK: - UITextFieldDelegate

extension CollectionHeader: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.trackerManager.changeName(name: textField.text)
        textField.endEditing(true)
        return false
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = 38
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }

    @objc private func textFieldDidChange(textField: UITextField) {
        guard (textField.text?.count) != nil else { return }
    }
}

// MARK: - Configure

extension CollectionHeader {
    private func setupViews() {
        contentView.setupView(strikeTitle)
        contentView.setupView(trackerNameInput)
        contentView.setupView(wrapperView)
        wrapperView.addArrangedSubview(categoryButton)
        if trackerManager.isRegular {
            wrapperView.addArrangedSubview(line)
            wrapperView.addArrangedSubview(scheduleButton)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            strikeTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            strikeTitle.topAnchor.constraint(equalTo: topAnchor),

            trackerNameInput.heightAnchor.constraint(equalToConstant: 75),
            trackerNameInput.topAnchor.constraint(equalTo: strikeTitle.bottomAnchor, constant: 24),
            trackerNameInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackerNameInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            wrapperView.topAnchor.constraint(equalTo: trackerNameInput.bottomAnchor, constant: 24),

            categoryButton.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 75)
        ])
        if trackerManager.isRegular {
            NSLayoutConstraint.activate([
                line.heightAnchor.constraint(equalToConstant: 1),
                line.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, constant: -32),
                line.topAnchor.constraint(equalTo: categoryButton.bottomAnchor),

                scheduleButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
                scheduleButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
                scheduleButton.heightAnchor.constraint(equalToConstant: 75),
                scheduleButton.topAnchor.constraint(equalTo: line.bottomAnchor)
            ])
        }
    }
}
