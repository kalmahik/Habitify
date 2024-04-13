//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class TrackerTypeModalViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 16
        return stack
    }()
    
    private lazy var regularButton = Button(title: "Привычка", color: .mainBlack) {
        let viewController = TrackerCreationViewController().wrapWithNavigationController()
        self.present(viewController, animated: true)
    }
    
    private let nonRegularButton = Button(title: "Нерегулярное событие", color: .mainBlack) {
        print("Нерегулярное событие")
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = "Создание трекера"
        view.setupView(wrapperView)
        wrapperView.addArrangedSubview(regularButton)
        wrapperView.addArrangedSubview(nonRegularButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            wrapperView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            wrapperView.heightAnchor.constraint(equalToConstant: 136), // how to avoid this?
            wrapperView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}
