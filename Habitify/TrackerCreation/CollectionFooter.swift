//
//  CollectionFooter.swift
//  Habitify
//
//  Created by kalmahik on 09.04.2024.
//

import UIKit

final class CollectionFooter: UICollectionViewCell {
    static let identifier = "CollectionFooter"
    
    weak var delegate: CollectionFooterDelegate?
    
    private let footerLabel = UILabel()
    
    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var cancelButton = Button(title: "Отменить", color: .mainRed, style: .flat) {
        self.parentViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    private lazy var creationButton = Button(title: "Создать", color: .mainBlack, style: .normal) {
        self.delegate?.didTapCreate()
    }

    // MARK: - Initializers
    
    func setupCell() {
        setupViews()
        setupConstraints()
    }
}

extension CollectionFooter {
    private func setupViews() {
        contentView.setupView(wrapperView)
        wrapperView.addArrangedSubview(cancelButton)
        wrapperView.addArrangedSubview(creationButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wrapperView.heightAnchor.constraint(equalToConstant: 60),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

