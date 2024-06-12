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
    static let emptyTracker = TrackerPreparation(
        id: nil,
        type: .regular,
        name: "",
        color: "",
        emoji: "",
        schedule: "",
        categoryName: "",
        createdAt: nil
    )

    var id: UUID?
    var name: String
    var color: String
    var emoji: String
    var schedule: String
    var categoryName: String
    var type: TrackerType
    var createdAt: Date?

    init(
        id: UUID?,
        type: TrackerType,
        name: String,
        color: String,
        emoji: String,
        schedule: String,
        categoryName: String,
        createdAt: Date?
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
        self.categoryName = categoryName
        self.createdAt = createdAt
    }

    init(from tracker: Tracker) {
        self.id = tracker.id
        self.name = tracker.name
        self.color = tracker.color
        self.emoji = tracker.emoji
        self.schedule = tracker.schedule
        self.categoryName = tracker.categoryName
        self.type = tracker.schedule.isEmpty ? .single : .regular
        self.createdAt = tracker.createdAt
    }
}
