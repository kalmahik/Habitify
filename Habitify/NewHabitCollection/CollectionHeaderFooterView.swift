//
//  CollectionHeaderFooterView.swift
//  Habitify
//
//  Created by kalmahik on 09.04.2024.
//

import UIKit

final class CollectionHeaderView: UICollectionReusableView {
    static let identifier = "CollectionHeaderView"
    private let headerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .lightGray
        headerLabel.text = "Header View"
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

final class CollectionFooterView: UICollectionReusableView {
    static let identifier = "CollectionFooterView"
    private let footerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .lightGray
        footerLabel.text = "Footer View"
        addSubview(footerLabel)
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            footerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            footerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
