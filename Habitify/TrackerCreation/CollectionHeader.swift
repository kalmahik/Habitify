//
//  CollectionHeader.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class CollectionHeader: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "CollectionHeader"
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private var trackerCreationManager = TrackerCreationManager.shared
    
    private lazy var trackerNameInput: UITextField = {
        let textField = TextField()
        textField.placeholder = "Введите название трекера"
        textField.backgroundColor = .mainBackgroud
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.done
        return textField
    }()

    private lazy var categoryButton = ArrowButton(title: "Категория", subtitle: "Главное") {
        let viewController = CategoriesScreenViewController().wrapWithNavigationController()
        self.parentViewController?.present(viewController, animated: true)
    }
    
    private lazy var scheduleButton = ArrowButton(
        title: "Расписание",
        subtitle: trackerCreationManager.newTracker.schedule
    ) {
        let viewController = ScheduleScreenViewController().wrapWithNavigationController()
        self.parentViewController?.present(viewController, animated: true)
    }
    
    private let titleView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 0
        return stack
    }()
    
    private let wrapperView: UIView =  {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGray
        return view
    }()
    
    // MARK: - Initializers
    
    // MARK: - Public Methods
    
    func setupCell() {
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
}

extension CollectionHeader: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        if textField == trackerNameInput {
//            trackerCreationManager.newTracker.name = textField.text ?? ""
//            NotificationCenter.default.post(
//                name: TrackerCreationViewController.footerDidChangeNotification, object: self
//            )
//        }
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.trackerCreationManager.changeName(name: textField.text)
        NotificationCenter.default.post(
            name: TrackerCreationViewController.footerDidChangeNotification, object: self
        )
        textField.endEditing(true)
        return false
    }
}

extension CollectionHeader {
    private func setupViews() {
        contentView.setupView(trackerNameInput)        
        contentView.setupView(wrapperView)
        wrapperView.setupView(categoryButton)
        wrapperView.setupView(line)
        wrapperView.setupView(scheduleButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            trackerNameInput.heightAnchor.constraint(equalToConstant: 75),
            trackerNameInput.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            trackerNameInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackerNameInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            wrapperView.heightAnchor.constraint(equalToConstant: 150),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            wrapperView.topAnchor.constraint(equalTo: trackerNameInput.bottomAnchor, constant: 24),
            
            categoryButton.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 75),
            
            line.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: categoryButton.bottomAnchor),
            
            scheduleButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            scheduleButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            scheduleButton.heightAnchor.constraint(equalToConstant: 75),
            scheduleButton.topAnchor.constraint(equalTo: line.bottomAnchor),
        ])
    }
}
