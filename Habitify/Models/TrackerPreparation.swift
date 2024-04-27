//
//  TrackerPreparation.swift
//  Habitify
//
//  Created by kalmahik on 23.04.2024.
//

import Foundation

struct TrackerPreparation {
    var id: UUID
    var type: TrackerType
    var name: String
    var color: String
    var emoji: String
    var schedule: String
}

class TrackerCreationManager {
    static let shared = TrackerCreationManager()
    
    private(set) var newTracker: TrackerPreparation
    
    var isValid: Bool {
        !newTracker.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !newTracker.schedule.isEmpty
    }
    
    private init() {
        self.newTracker = defaultTracker
    }
    
    private let defaultTracker = TrackerPreparation(
        id: UUID(),
        type: .regular,
        name: "",
        color: "#832CF1FF",
        emoji: "🙂",
        schedule: ""
    )
    
    func resetCreation() {
        newTracker = defaultTracker
    }
    
    func changeName(name: String?) {
        newTracker.name = name ?? ""
        NotificationCenter.default.post(
            name: TrackerCreationViewController.reloadCollection, object: self
        )
    }
    
    func changeSchedule(schedule: [DayOfWeekItem]) {
        let schedule = DayOfWeek.scheduleToString(schedule: scheduleCollectionData)
        newTracker.schedule = schedule
        NotificationCenter.default.post(
            name: TrackerCreationViewController.reloadCollection, object: self
        )
    }
}
