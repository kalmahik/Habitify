//
//  ScheduleCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class ScheduleCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let identifier = "ScheduleCell"
    
    weak var delegate: ScheduleCellDelegate?
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .mainBlue
        toggle.addTarget(self, action: #selector(didSwitchTapped), for: .allEvents)
        return toggle
    }()
    
    // MARK: - Initializers

    // MARK: - Public Methods
    
    func setupCell(schedule: DayOfWeekItem) {
        setupViews()
        setupConstraints()
        titleLabel.text = schedule.dayOfWeek.fullName
        toggle.isOn = schedule.isEnabled
    }
    
    // MARK: - Private Methods
    
    @objc func didSwitchTapped(switch: UISwitch) {
        delegate?.didTapSwitch(self)
    }
}

extension ScheduleCell {
    private func setupViews() {
        contentView.setupView(titleLabel)
        contentView.setupView(toggle)
        contentView.backgroundColor = .mainBackgroud
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: toggle.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            toggle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            toggle.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
