//
//  Tracker.swift
//  Habitify
//
//  Created by kalmahik on 09.04.2024.
//

import Foundation

enum TrackerType {
    case regular
    case single
}

struct Tracker {
    let id: UUID
    let type: TrackerType
    let name: String
    let color: String
    let emoji: String
    let schedule: String
}
