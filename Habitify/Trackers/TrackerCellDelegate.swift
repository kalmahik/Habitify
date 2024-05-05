//
//  TrackerCellDelegate.swift
//  Habitify
//
//  Created by Murad Azimov on 27.04.2024.
//

import Foundation

protocol TrackerCellDelegate: AnyObject {
    func didTapPlusButton(_ cell: TrackerCell)
}
