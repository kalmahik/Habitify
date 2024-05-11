//
//  Tracker.swift
//  Habitify
//
//  Created by kalmahik on 09.04.2024.
//

import Foundation

struct Tracker {
    let id: UUID
    let name: String
    let color: String
    let emoji: String
    let schedule: String

    init(id: UUID, name: String, color: String, emoji: String, schedule: String) {
        self.id = id
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
    }

    init(from tracker: TrackerPreparation) {
        self.id = UUID()
        self.name = tracker.name
        self.color = tracker.color
        self.emoji = tracker.emoji
        self.schedule = tracker.schedule
    }
    
    init(from tracker: TrackerCoreData) {
        self.id = tracker.id ?? UUID()
        self.name = tracker.name ?? ""
        self.color = tracker.color ?? ""
        self.emoji = tracker.emoji ?? ""
        self.schedule = tracker.schedule ?? ""
    }
}
