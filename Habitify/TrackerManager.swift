//
//  TrackerManager.swift
//  Habitify
//
//  Created by kalmahik on 27.04.2024.
//

import Foundation

class TrackerManager {
    static let shared = TrackerManager()
    
    var weekDayList: [DayOfWeekSwitch]
    
    private(set) var newTracker: TrackerPreparation
    
    // почему нельзя сделать как обычно private let isRegular = ...?
    var isRegular: Bool {
        newTracker.type == .regular
    }
    
    var isValid: Bool {
        !newTracker.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        (isRegular ? !newTracker.schedule.isEmpty : true)
    }
    
    private init() {
        self.newTracker = defaultTracker
        self.weekDayList = defaultDayList
    }
    
    private let defaultDayList = DayOfWeek.allCases.map {
        DayOfWeekSwitch(dayOfWeek: $0, isEnabled: false)
    }
    
    private let defaultTracker = TrackerPreparation(
        id: UUID(),
        type: .regular,
        name: "",
        color: "#832CF1FF",
        emoji: "🙂",
        schedule: ""
    )

    func resetCurrentTracker() {
        newTracker = defaultTracker
        weekDayList = defaultDayList
    }
    
    func changeType(trackerType: TrackerType) {
        self.newTracker.type = trackerType
    }
    
    func changeName(name: String?) {
        newTracker.name = name ?? ""
        NotificationCenter.default.post(
            name: TrackerCreationViewController.reloadCollection, object: self
        )
    }
    
    func changeSchedule(schedule: [DayOfWeekSwitch]) {
        let schedule = DayOfWeek.scheduleToString(schedule: weekDayList)
        newTracker.schedule = schedule
        NotificationCenter.default.post(
            name: TrackerCreationViewController.reloadCollection, object: self
        )
    }
}
