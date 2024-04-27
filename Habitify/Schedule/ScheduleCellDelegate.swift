//
//  ScheduleCellDelegate.swift
//  Habitify
//
//  Created by kalmahik on 22.04.2024.
//

import Foundation

protocol ScheduleCellDelegate: AnyObject {
    func didTapSwitch(_ cell: ScheduleCell)
}
