//
//  SectionHeader.swift
//  Habitify
//
//  Created by kalmahik on 08.04.2024.
//

import UIKit

final class TrackerSectionHeader: UICollectionReusableView {
    
    // MARK: - Constants
    
    static let identifier = "TrackerSectionHeader"
    
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

extension TrackerSectionHeader {
    private func setupViews() {
        layer.borderWidth = 1
        setupView(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
}
