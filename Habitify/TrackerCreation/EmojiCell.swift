//
//  HumanViewCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class EmojiCell: UICollectionViewCell {

    // MARK: - Constants

    static let identifier = "EmojiCell"

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var isSelected: Bool {
        didSet {
            emojiLabel.backgroundColor = isSelected ? .mainLightGray : .mainWhite
        }
    }

    // MARK: - Private Properties

    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Public Methods

    func setupCell(emoji: String) {
        emojiLabel.text = emoji
    }
}

// MARK: - Configure

extension EmojiCell {
    private func setupViews() {
        contentView.setupView(emojiLabel)
        emojiLabel.layer.cornerRadius = 16
        emojiLabel.layer.masksToBounds = true
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emojiLabel.widthAnchor.constraint(equalToConstant: 52),
            emojiLabel.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
