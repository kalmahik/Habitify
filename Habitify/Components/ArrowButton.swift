//
//  ArrowButton.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit


final class ArrowButton: UIView {
    // как сделать поля опциональными
    var action: () -> Void = {} //чет какая-то дичь, может можно проще?

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
    
    // попахивает говном
    @objc private func didTapButton() {
        action()
    }
    
    private func setupViews() {
        setupView(titleLabel)
        setupView(image)
        backgroundColor = .mainLigthGray
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapRecognizer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -16),
            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
