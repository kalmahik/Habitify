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

    private lazy var checkImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark"))
        return image
    }()

    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        return stack
    }()

    // MARK: - Initializers

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
    // MARK: - Public Methods

    func setupCell(category: TrackerCategory) {
        setupViews()
        setupConstraints()
        titleLabel.text = category.title
    }

    func selectCell() {
        titleLabel.backgroundColor = .gray
    }

    // MARK: - Private Methods
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
