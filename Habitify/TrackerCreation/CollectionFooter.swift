//
//  CollectionFooter.swift
//  Habitify
//
//  Created by kalmahik on 09.04.2024.
//

import UIKit

final class CollectionFooter: UICollectionViewCell {
    static let identifier = "CollectionFooter"
    
    private let footerLabel = UILabel()
    
    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var cancelButton = Button(title: "Отменить", color: .mainRed, style: .flat) {
    }
    
    private lazy var creationButton = Button(title: "Создать", color: .mainBlack, style: .normal) {
    }

    // MARK: - Initializers
    
    convenience init() {
        self.init()
    }
    
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

