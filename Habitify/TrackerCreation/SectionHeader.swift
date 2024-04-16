//
//  SectionHeader.swift
//  Habitify
//
//  Created by kalmahik on 08.04.2024.
//

import UIKit

final class SectionHeader: UICollectionReusableView {
    
    // MARK: - Constants
    
    static let identifier = "SectionHeader"
    
    // MARK: - Private Properties

    private lazy var titleLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Public Methods
    
    // а точно нам нужен этот метод? есть же инит, может его заюзать?
    func setupSection(title: String) {
        titleLabel.text = title
    }
}

extension SectionHeader {
    private func setupViews() {
        setupView(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        ])
    }
}
