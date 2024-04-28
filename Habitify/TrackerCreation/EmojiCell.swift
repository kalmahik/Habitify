//
//  HumanViewCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class EmojiCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "EmojiCell"
    
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
        setupViews()
        setupConstraints()
    }
    
    func selectCell() {
        emojiLabel.backgroundColor = .gray
    }
}

// MARK: - Configure

extension EmojiCell {
    private func setupViews() {
        contentView.setupView(emojiLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
