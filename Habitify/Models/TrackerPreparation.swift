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
        type: .regular,
        name: "",
        color: "",
        emoji: "",
        schedule: "",
        categoryName: ""
    )

    var type: TrackerType

    var name: String
    var color: String
    var emoji: String
    var schedule: String
    var categoryName: String

    //    let id: UUID
    //    let createdAt: Date

    init(type: TrackerType, name: String, color: String, emoji: String, schedule: String, categoryName: String) {
        self.type = type
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
        self.categoryName = categoryName
    }

    init(from tracker: Tracker) {
        self.name = tracker.name
        self.color = tracker.color
        self.emoji = tracker.emoji
        self.schedule = tracker.schedule
        self.categoryName = tracker.categoryName
        self.type = tracker.schedule.isEmpty ? .single : .regular
    }
}
