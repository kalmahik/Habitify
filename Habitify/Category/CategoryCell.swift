//
//  CategoryCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class CategoryCell: UITableViewCell {

    // MARK: - Constants

    static let identifier = "CategoryCell"

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var checkImage: UIImageView = UIImageView(image: UIImage(systemName: "checkmark"))

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

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

    // MARK: - Public Methods

    func setupCell(category: TrackerCategory, isFirst: Bool, isLast: Bool) {
        titleLabel.text = category.title
        separator.isHidden = isLast
        backgroundColor = .mainBackgroud
        clipsToBounds = true
        layer.cornerRadius = 16
        if isFirst && isLast {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else if isFirst {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if isLast {
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            layer.maskedCorners = []
        }
    }

    func selectCell() {
        titleLabel.backgroundColor = .gray
    }
}

extension CategoryCell {
    private func setupViews() {
        setupView(titleLabel)
        setupView(checkImage)
        setupView(separator)
        backgroundColor = .mainLigthGray
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 75),

            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: checkImage.leadingAnchor),

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
