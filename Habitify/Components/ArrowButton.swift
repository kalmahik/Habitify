//
//  ArrowButton.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit


final class ArrowButton: UIView {

    var action: () -> Void = {}

    convenience init(title: String, action: @escaping () -> Void) {
        self.init()
        titleLabel.text = title
        self.action = action
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName:  "chevron.forward"))
        image.tintColor = .mainGray
        return image
    }()

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
