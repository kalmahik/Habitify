//
//  StatisticCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class StatisticCell: UIView {

    // MARK: - Private properties

    private var gradient = CAGradientLayer()
    private let gradientColors = [
        UIColor(hex: "#FD4C49FF")!.cgColor,
        UIColor(hex: "#46E69DFF")!.cgColor,
        UIColor(hex: "#007BFAFF")!.cgColor
    ]

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupGradientView()
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }

    func updateCount(_ count: Int, _ message: String) {
        titleLabel.text = "\(count)"
        subtitleLabel.text = message
    }

    private func setupGradientView() {
        gradient.colors = gradientColors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradient)
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }

    // MARK: - UIViews

    private var cellBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .mainWhite
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
}

// MARK: - Configure

extension StatisticCell {
    private func setupViews() {
        setupView(cellBackgroundView)
        setupView(titleLabel)
        setupView(subtitleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
    }
}
