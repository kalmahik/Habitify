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
        label.layer.borderWidth = 1
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setupCell(emoji: String) {
        emojiLabel.text = emoji
    }
    
    func selectCell() {
        emojiLabel.backgroundColor = .gray
    }
    
    // MARK: - Private Methods
}

extension EmojiCell {
    private func setupViews() {
        contentView.layer.borderWidth = 1
        contentView.setupView(emojiLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
