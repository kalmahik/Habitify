//
//  ArrowButton.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit


final class ArrowButton: UIControl {

    var action: () -> Void

    init(title: String, action: @escaping () -> Void = {}) {
        self.action = action
        super.init(frame: .zero)
        titleLabel.text = title
        addTarget(self, action: #selector(tapOnSelf), for: .touchUpInside)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName:  "chevron.forward"))
        image.tintColor = .mainGray
        return image
    }()
    
    @objc private func tapOnSelf() {
        action()
    }

    private func setupViews() {
        setupView(titleLabel)
        setupView(image)
        addTapGesture(action)
        backgroundColor = .mainLigthGray
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
