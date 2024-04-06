//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
    }
    
    // MARK: - Configure

    private func configureView() {
        view.backgroundColor = .mainWhite
    }
    
    private func configureNavBar() {
        navigationItem.title = "Трекеры"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        add.tintColor = .mainBlack
        navigationItem.leftBarButtonItem = add
    }
    
    @objc private func addTapped() {
        
    }
}
