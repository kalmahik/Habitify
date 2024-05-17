//
//  EmptyTrackersView.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

final class EmptyView: UIView {

    var emoji = ""

    init(emoji: String, title: String) {
        super.init(frame: .zero)
        self.emoji = emoji
        titleLabel.text = title
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }

    private lazy var emojiImage = UIImageView(image: emoji.makeImage()?.noir)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    private func setupSubviews() {
        setupView(emojiImage)
        setupView(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emojiImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiImage.centerYAnchor.constraint(equalTo: centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: emojiImage.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
