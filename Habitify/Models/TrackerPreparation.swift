//
//  TrackerPreparation.swift
//  Habitify
//
//  Created by kalmahik on 23.04.2024.
//

import Foundation

enum TrackerType {
    case regular
    case single
}

struct TrackerPreparation {
    var type: TrackerType

    var name: String
    var color: String
    var emoji: String
    var schedule: String
    var categoryName: String

//    let id: UUID
//    let createdAt: Date
}
