//
//  FilterCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class FilterCell: UITableViewCell {

    // MARK: - Constants

    static let identifier = "FilterCell"

    // MARK: - Public Properties

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        checkImage.isHidden = !selected
    }

    // MARK: - UIViews

    private lazy var titleLabel: UILabel = UILabel()

    private lazy var checkImage: UIImageView = UIImageView(image: UIImage(systemName: "checkmark"))

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .mainLigthGray
        return view
    }()

    // MARK: - Public Methods

    func setupCell(label: String, isFirst: Bool, isLast: Bool) {
        titleLabel.text = label
        separator.isHidden = isLast

        clipsToBounds = true
        layer.cornerRadius = 16
        if isFirst {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if isLast {
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            layer.maskedCorners = []
        }
    }
}

// MARK: - Configure

extension FilterCell {
    private func setupViews() {
        setupView(titleLabel)
        setupView(checkImage)
        setupView(separator)
        backgroundColor = .mainBackgroud
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: checkImage.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            checkImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            checkImage.widthAnchor.constraint(equalToConstant: 24),
            checkImage.heightAnchor.constraint(equalToConstant: 24),
            checkImage.centerYAnchor.constraint(equalTo: centerYAnchor),

            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
