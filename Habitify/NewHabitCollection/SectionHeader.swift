//
//  Footer.swift
//  Habitify
//
//  Created by kalmahik on 08.04.2024.
//

import UIKit

final class SectionHeader: UICollectionReusableView {
    
    // MARK: - Constants
    
    static let identifier = "SectionHeader"
    
    // MARK: - Private Properties

    private let titleLabel = UILabel()
    
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
        layer.borderWidth = 1
        setupView(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
