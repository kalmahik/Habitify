//
//  EmptyTrackersView.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

final class EmptyTrackersView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    private lazy var emojiLabel: UILabel = {
        let emoji = UILabel()
        emoji.text = "💫"
        emoji.textAlignment = .center
        emoji.font = UIFont.systemFont(ofSize: 80, weight: .regular)
        emoji.translatesAutoresizingMaskIntoConstraints = false
        return emoji
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Что будем отслеживать?"
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private func setupSubviews() {
        setupView(emojiLabel)
        setupView(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
