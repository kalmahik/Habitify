//
//  PageViewController.swift
//  Habitify
//
//  Created by kalmahik on 17.05.2024.
//

import UIKit

final class PageViewController: UIViewController {
    // MARK: - Public Properties

    var page: Pages

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = page.name
        return label
    }()
    
    // MARK: - Initializers
    
    init(with page: Pages) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Configure

extension PageViewController {

    private func setupViews() {
        view.backgroundColor = .mainWhite
        view.setupView(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
