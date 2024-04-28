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
    
    // почему нельзя сделать так:
//    private let schedule = trackerManager.shared.newTracker.schedule
    
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
        subtitle: trackerManager.newTracker.schedule
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
            
    // MARK: - Public Methods
    
    func setupCell() {
        // это ок что эти методы тут? или они должны быть в ините?
        setupViews()
        setupConstraints()
        scheduleButton.updateSubtitle(subtitle: trackerManager.newTracker.schedule)

    }
    
    // MARK: - Private Methods
}

extension CollectionHeader: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.trackerManager.changeName(name: textField.text)
        textField.endEditing(true)
        return false
    }
}

extension CollectionHeader {
    private func setupViews() {
        contentView.setupView(trackerNameInput)        
        contentView.setupView(wrapperView)
        wrapperView.setupView(categoryButton)
        if trackerManager.isRegular {
            wrapperView.setupView(line)
            wrapperView.setupView(scheduleButton)
        }
        wrapperView.setNeedsLayout()
        wrapperView.layoutIfNeeded()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            trackerNameInput.heightAnchor.constraint(equalToConstant: 75),
            trackerNameInput.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            trackerNameInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackerNameInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // как сделать нормально?
            wrapperView.heightAnchor.constraint(equalToConstant: trackerManager.isRegular ?  150 : 75),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            wrapperView.topAnchor.constraint(equalTo: trackerNameInput.bottomAnchor, constant: 24),
            
            categoryButton.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 75),
        ])
        // переиспользование попахивает говном, но как лучше?
        if trackerManager.isRegular {
            NSLayoutConstraint.activate([
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
}
