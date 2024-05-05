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
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()

    private lazy var checkImage: UIImageView = UIImageView(image: UIImage(systemName: "checkmark"))

    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        return stack
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
    
    // MARK: - Public Methods

    func setupCell(category: TrackerCategory) {
        titleLabel.text = category.title
    }

    func selectCell() {
        titleLabel.backgroundColor = .gray
    }
}

extension CategoryCell {
    private func setupViews() {
        contentView.setupView(titleLabel)
        contentView.setupView(checkImage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: checkImage.leadingAnchor),
            checkImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ])
    }
}
