//
//  HumanViewCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class TrackerCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "TrackerCell"
    
    // MARK: - Public Properties

    weak var delegate: TrackerCellDelegate?
    
    // MARK: - Private Properties
    
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var quantityManagementView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var emojiWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .mainWhite30
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var emoji: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "plus") ?? UIImage(),
            target: self,
            action: #selector(didTapPlusButton)
        )
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Methods
    
    func setupCell(tracker: Tracker, count: Int) {
        let color = UIColor(hex: tracker.color)
        cellBackgroundView.backgroundColor = color
        plusButton.tintColor = color
        emoji.text = tracker.emoji
        titleLabel.text = tracker.name
        quantityLabel.text = String(count)
    }
    
    func selectCell() {
    }
    
    // MARK: - Private Methods
    
    @objc private func didTapPlusButton() {
        delegate?.didTapPlusButton(self)
    }
}

// MARK: - Configure

extension TrackerCell {
    private func setupViews() {
        contentView.setupView(cellBackgroundView)
        contentView.setupView(quantityManagementView)
        cellBackgroundView.setupView(emojiWrapper)
        emojiWrapper.setupView(emoji)
        cellBackgroundView.setupView(titleLabel)
        quantityManagementView.setupView(quantityLabel)
        quantityManagementView.setupView(plusButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 90),
            
            quantityManagementView.topAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor),
            quantityManagementView.heightAnchor.constraint(equalToConstant: 58),
            quantityManagementView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            quantityManagementView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            emojiWrapper.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 12),
            emojiWrapper.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            emojiWrapper.heightAnchor.constraint(equalToConstant: 24),
            emojiWrapper.widthAnchor.constraint(equalToConstant: 24),
            
            emoji.centerXAnchor.constraint(equalTo: emojiWrapper.centerXAnchor),
            emoji.centerYAnchor.constraint(equalTo: emojiWrapper.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -12),

            quantityLabel.topAnchor.constraint(equalTo: quantityManagementView.topAnchor, constant: 16),
            quantityLabel.leadingAnchor.constraint(equalTo: quantityManagementView.leadingAnchor, constant: 12),
            
            plusButton.topAnchor.constraint(equalTo: quantityManagementView.topAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: quantityManagementView.trailingAnchor, constant: -12),
            plusButton.widthAnchor.constraint(equalToConstant: 34),
            plusButton.heightAnchor.constraint(equalToConstant: 34),
        ])
    }
}
