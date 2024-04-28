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

    init(id: UUID, type: TrackerType, name: String, color: String, emoji: String, schedule: String) {
        self.id = id
        self.type = type
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
    }

    init(_ newTracker: TrackerPreparation) {
        self.id = UUID()
        self.type = newTracker.type
        self.name = newTracker.name
        self.color = newTracker.color
        self.emoji = newTracker.emoji
        self.schedule = newTracker.schedule
    }
}
