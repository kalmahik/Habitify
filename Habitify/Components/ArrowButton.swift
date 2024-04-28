//
//  ArrowButton.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

final class ArrowButton: UIControl {

    var action: () -> Void

    init(title: String, subtitle: String? = "", action: @escaping () -> Void = {}) {
        self.action = action
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        addTarget(self, action: #selector(tapOnSelf), for: .touchUpInside)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateSubtitle(subtitle: String? = "") {
        subtitleLabel.text = subtitle
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGray
        return label
    }()

    private lazy var wrapper: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.equalCentering
        stack.spacing = 2
        return stack
    }()

    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "chevronRight"))
        image.tintColor = .mainGray
        return image
    }()

    @objc private func tapOnSelf() {
        action()
    }

    private func setupViews() {
        wrapper.addArrangedSubview(titleLabel)
        wrapper.addArrangedSubview(subtitleLabel)
        setupView(wrapper)
        setupView(image)
        addTapGesture(action)
        backgroundColor = .mainBackgroud
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wrapper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            wrapper.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -16),
            wrapper.centerYAnchor.constraint(equalTo: centerYAnchor),

            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            image.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
