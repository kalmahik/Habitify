//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class CategoriesScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var addCategoryButton = Button(title: "Добавить категорию", color: .mainBlack) {
        self.present(CategoryCreationViewController().wrapWithNavigationController(), animated: true)
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
        view.setupView(addCategoryButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            addCategoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    

}
