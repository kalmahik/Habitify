//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class CategoryScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var regularButton = Button(title: "Добавить категорию", color: .mainBlack) {
    }
    
    private lazy var emptyView = EmptyView(emoji: "💫", title: "Привычки и события можно объединить по смыслу")
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = "Категория"
        view.setupView(emptyView)
        view.setupView(regularButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            regularButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            regularButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            regularButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    

}
