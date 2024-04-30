//
//  TrackerManager.swift
//  Habitify
//
//  Created by kalmahik on 27.04.2024.
//

import Foundation

class TrackerManager {
    static let shared = TrackerManager()

    private(set) var selectedDay: Date = Date()
    private(set) var weekDayList: [DayOfWeekSwitch]
    private(set) var trackerRecord: [UUID: [Date]] = [:]
    private(set) var trackers: [TrackerCategory] = [] // trackersMockData
    private(set) var newTracker: TrackerPreparation
    private(set) var error: String?

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

    func changeSelectedDay(selectedDay: Date) {
        self.selectedDay = selectedDay
        NotificationCenter.default.post(name: TrackersViewController.reloadCollection, object: self)
    }

    func changeSelectedSchedules(indexPath: IndexPath) {
        let weekDay = weekDayList[indexPath.row]
        weekDayList[indexPath.row].isEnabled = !weekDay.isEnabled
    }

    func changeType(trackerType: TrackerType) {
        self.newTracker.type = trackerType
    }

    func changeName(name: String?) {
        newTracker.name = name ?? ""
        NotificationCenter.default.post(name: TrackerCreationViewController.reloadCollection, object: self)
    }

    func changeSchedule(schedule: [DayOfWeekSwitch]) {
        let schedule = DayOfWeek.scheduleToString(schedule: weekDayList)
        newTracker.schedule = schedule
        NotificationCenter.default.post(name: TrackerCreationViewController.reloadCollection, object: self)
    }
    
    // может быть его отрефакторить следует
    func isTrackerCompleteForSelectedDay(trackerUUID: UUID) -> Int {
        guard let trackerRecord = trackerRecord[trackerUUID] else { return -1 }
        return trackerRecord.firstIndex(where: {
            Calendar.current.isDate($0, equalTo: selectedDay, toGranularity: .day)
        }) ?? -1
    }

    func makeRecord(trackerUUID: UUID) {
        if trackerRecord[trackerUUID] != nil {
            let dayExist = isTrackerCompleteForSelectedDay(trackerUUID: trackerUUID)
            if dayExist >= 0 {
                trackerRecord[trackerUUID]?.remove(at: dayExist)
            } else {
                trackerRecord[trackerUUID]?.append(selectedDay)
            }
        } else {
            trackerRecord[trackerUUID] = [selectedDay]
        }
        NotificationCenter.default.post(name: TrackersViewController.reloadCollection, object: self)
    }

    func createTracker() {
        let categoryIndex = trackers.firstIndex { $0.title == "Главнное" } ?? -1
        if categoryIndex == -1 {
            trackers.append(TrackerCategory(title: "Главнное", trackers: [Tracker(newTracker)]))
        } else {
            trackers[categoryIndex].trackers.append(Tracker(newTracker))
        }
        NotificationCenter.default.post(name: TrackersViewController.reloadCollection, object: self)
    }

    func getTrackers() {
        for category in trackers {
            let filteredByDay = category.trackers.filter {
                let schedule = DayOfWeek.stringToSchedule(scheduleString: $0.schedule).map { $0.dayOfWeek }
//                let selectedDayOfWeek = selectedDay.w
//                let exist = schedule.contains(/*<#T##other: Collection##Collection#>*/)
                return false
            }
        }
    }

    func getTrackerByIndexPath(at indexPath: IndexPath) -> Tracker {
        trackers[indexPath.section].trackers[indexPath.row]
    }
    
    func setError(error: String?) {
        self.error = error
    }
}
