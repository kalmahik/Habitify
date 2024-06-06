//
//  ScheduleCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class ScheduleCell: UITableViewCell {

    // MARK: - Constants

    static let identifier = "ScheduleCell"

    // MARK: - Public Properties

    weak var delegate: ScheduleCellDelegate?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - UIViews

    private lazy var titleLabel: UILabel = UILabel()

    private lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .mainBlue
        toggle.addTarget(self, action: #selector(didSwitchTapped), for: .allEvents)
        return toggle
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .mainLightGray
        return view
    }()

    // MARK: - Public Methods

    func setupCell(schedule: DayOfWeekSchedule, isFirst: Bool, isLast: Bool) {
        titleLabel.text = schedule.dayOfWeek.fullName
        toggle.isOn = schedule.isEnabled
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

    // MARK: - Private Methods

    @objc func didSwitchTapped(switch: UISwitch) {
        delegate?.didTapSwitch(self)
    }
}

// MARK: - Configure

extension ScheduleCell {
    private func setupViews() {
        setupView(titleLabel)
        setupView(toggle)
        setupView(separator)
        backgroundColor = .mainBackground
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: toggle.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            toggle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            toggle.centerYAnchor.constraint(equalTo: centerYAnchor),

            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
