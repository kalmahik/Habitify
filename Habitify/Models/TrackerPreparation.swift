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

struct TrackerCreationManager {
    static let shared = TrackerCreationManager()
    
    var newTracker: TrackerPreparation
    
    var isValid: Bool {
        //        !newTracker.name.trimmingCharacters(
        //            in: .whitespacesAndNewlines
        //        ).isEmpty
        true
    }
    
    private init() {
        print("INIT")
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
    
    mutating func resetCreation() {
        newTracker = defaultTracker
    }
    
    mutating func changeName(name: String?) {
        newTracker.name = name ?? ""
    }
}
