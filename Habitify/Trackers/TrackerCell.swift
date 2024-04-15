//
//  HumanViewCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class TrackerCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "TrackerCell"
    
    // MARK: - Private Properties
    
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var quantityManagementView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var emojiWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#FFFFFF4D")
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
//        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var emoji: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
//        label.layer.borderWidth = 1
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 2
        label.layer.borderWidth = 1
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.borderWidth = 1
        return label
    }()
    
//    private lazy var plusButton: UIButton = {
//        let button  = UIButton(type: .custom)
//        button.setImage(UIImage(named: "plus.circle.fill"), for: .normal)
//        button.tintColor = .ypRed
//        return button
//    }()
    
    private lazy var plusButton: UIButton = {
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 34, weight: .regular, scale: .large)
        let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: imageConfig)
        let button = UIButton.systemButton(
            with: plusImage ?? UIImage(),
            target: self,
            action: #selector(didTapPlusButton)
        )
        button.layer.borderWidth = 1
        button.tintColor = .red
        return button
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
    
    func setupCell(tracker: Tracker) {
        let color = UIColor(hex: tracker.color)
        cellBackgroundView.backgroundColor = color
        plusButton.tintColor = color
        emoji.text = tracker.emoji
        titleLabel.text = tracker.name
        quantityLabel.text = tracker.schedule
    }
    
    func selectCell() {
//        emojiLabel.backgroundColor = .gray
    }
    
    // MARK: - Private Methods
    
    @objc private func didTapPlusButton() {
    }
}

extension TrackerCell {
    private func setupViews() {
        contentView.layer.borderWidth = 1
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
