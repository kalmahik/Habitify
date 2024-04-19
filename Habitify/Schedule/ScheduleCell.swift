//
//  ScheduleCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class ScheduleCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let identifier = "ScheduleCell"
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .mainBlue
        return toggle
    }()
    
    // MARK: - Initializers

    // MARK: - Public Methods
    
    func setupCell(schedule: DayOfWeekItem) {
        setupViews()
        setupConstraints()
        titleLabel.text = schedule.dayOfWeek.fullName
    }
    
    func selectCell() {
        titleLabel.backgroundColor = .gray
    }
    
    // MARK: - Private Methods
}

extension ScheduleCell {
    private func setupViews() {
        contentView.setupView(titleLabel)
        contentView.setupView(toggle)
        contentView.backgroundColor = .mainLigthGray
        let isoDate = "2024-04-21T17:44:00+0000"
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: date)
        let dayOfWeek = calendar.component(.weekday, from: today)
        print(dayOfWeek)
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
