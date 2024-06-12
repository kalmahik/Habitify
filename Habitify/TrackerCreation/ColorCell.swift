//
//  ColorCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class ColorCell: UICollectionViewCell {

    // MARK: - Constants

    static let identifier = "ColorCell"

    // MARK: - Private properties

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
            layer.borderWidth = 3
            layer.cornerRadius = 8
            layer.borderColor = isSelected ?
                colorView.backgroundColor?.withAlphaComponent(0.3).cgColor : UIColor.mainWhite.cgColor
        }
    }

    // MARK: - Private Properties

    private lazy var colorView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    // MARK: - Public Methods

    func setupCell(color: UIColor) {
        colorView.backgroundColor = color
    }
}

// MARK: - Configure

extension ColorCell {
    private func setupViews() {
        contentView.setupView(colorView)
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
