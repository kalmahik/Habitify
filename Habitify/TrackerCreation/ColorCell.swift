//
//  ColorCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class ColorCell: UICollectionViewCell {

    // MARK: - Constants

    static let identifier = "ColorCell"
    
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
            contentView.layer.borderWidth = 3
            contentView.layer.borderColor = isSelected ?
            colorView.backgroundColor?.withAlphaComponent(0.3).cgColor : UIColor.mainWhite.cgColor
            contentView.layer.cornerRadius = 16
            contentView.layer.masksToBounds = true
        }
    }
    
    // MARK: - Private Properties

    private lazy var colorView: UIView = UIView()

    // MARK: - Public Methods

    func setupCell(color: UIColor) {
        colorView.backgroundColor = color
    }
}

// MARK: - Configure

extension ColorCell {
    private func setupViews() {
        contentView.setupView(colorView)
        colorView.layer.cornerRadius = 8
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 52),
            contentView.heightAnchor.constraint(equalToConstant: 52),
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
