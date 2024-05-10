//
//  TrackerManager.swift
//  Habitify
//
//  Created by kalmahik on 27.04.2024.
//

import Foundation

final class TrackerManager {
    static let shared = TrackerManager()
    
    private(set) var selectedDay: Date = Date()
    private(set) var weekDayList: [DayOfWeekSwitch]
    private(set) var trackerRecord: [UUID: [Date]] = [:]
    private(set) var newTracker: TrackerPreparation
    private(set) var error: String?
    private var trackers: [TrackerCategory] = [] // trackersMockData
    private let defaultDayList = DayOfWeek.allCases.map { DayOfWeekSwitch(dayOfWeek: $0, isEnabled: false) }
    private let defaultTracker = TrackerPreparation(type: .regular, name: "", color: "", emoji: "", schedule: "")
    private let trackerStore = TrackerStore.shared
    private let categoryStore = TrackerCategoryStore.shared
    
    private init() {
        self.newTracker = defaultTracker
        self.weekDayList = defaultDayList
    }
    
    // MARK: - Tracker list properties
    
    var filteredtrackers: [TrackerCategory] {
        let categories = categoryStore.getCategories()
        return categories
//        trackers.map { TrackerCategory(title: $0.title, trackers: $0.trackers.filter {
//            // немного сэкономим на вычислениях, и если трекер не регуляроный, то отображаем его всегда
//            if $0.schedule.isEmpty {
//                return true
//            }
//            // для удобства сравнения, превратим его в массив стрингов
//            let schedule = DayOfWeek.stringToSchedule(scheduleString: $0.schedule).map { String(describing: $0.dayOfWeek) }
//            let selectedDayOfWeek = selectedDay.dayOfWeek()
//            return schedule.contains(selectedDayOfWeek)
//        })}
//        .filter { !$0.trackers.isEmpty } //убираем пустые категории
    }

    // MARK: - Creation properties
    
    var isRegular: Bool { newTracker.type == .regular }
    
    var isValid: Bool {
        !newTracker.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        (isRegular ? !newTracker.schedule.isEmpty : true) &&
        !newTracker.emoji.isEmpty &&
        !newTracker.color.isEmpty
    }
    
    // MARK: - Tracker list methods
    
    func changeSelectedDay(selectedDay: Date) {
        self.selectedDay = selectedDay
        updateTrackersUI()
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
        updateTrackersUI()
    }
    
    // MARK: - Creation methods
    
    func changeType(trackerType: TrackerType) {
        self.newTracker.type = trackerType
    }
    
    func changeName(name: String?) {
        newTracker.name = name ?? ""
        updateCreationUI()
    }
    
    func changeSchedule(schedule: [DayOfWeekSwitch]) {
        let schedule = DayOfWeek.scheduleToString(schedule: weekDayList)
        newTracker.schedule = schedule
        updateCreationUI()
    }
    
    func changeSelectedSchedules(indexPath: IndexPath) {
        let weekDay = weekDayList[indexPath.row]
        weekDayList[indexPath.row].isEnabled = !weekDay.isEnabled
    }
    
    func changeEmoji(emoji: String?) {
        self.newTracker.emoji = emoji ?? ""
        updateCreationUI()
    }
    
    func changeColor(color: String?) {
        self.newTracker.color = color ?? ""
        updateCreationUI()
    }
    
    func setError(error: String?) {
        self.error = error
    }
    
    func createTracker(categoryName: String) {
//        let categoryIndex = trackers.firstIndex { $0.title == categoryName } ?? -1
//        let tracker = Tracker(from: newTracker)
//        if categoryIndex >= 0 {
//            let trackers = trackers[categoryIndex].trackers + [tracker]
//            let category = TrackerCategory(title: categoryName, trackers: trackers)
//            self.trackers.remove(at: categoryIndex)
//            self.trackers.insert(category, at: categoryIndex)
//        } else {
//            trackers = trackers + [TrackerCategory(title: categoryName, trackers: [tracker])]
//        }
        let tracker = Tracker(from: newTracker)
//        let categoryEntity = categoryStore.createСategory(with: categoryName)
//        trackerStore.createTracker(with: tracker, category: categoryEntity)
        trackerStore.createTracker(with: tracker)
        updateTrackersUI()
    }
    
    // MARK: - Utils
    
    func updateCreationUI() {
        // выглядит это не очень, т к менеджер обновляет юай, но пока оставим это тут
        NotificationCenter.default.post(name: TrackerCreationViewController.reloadCollection, object: self)
    }
    
    func updateTrackersUI() {
        //если трекеров много будет - то это не эффективно, лучше точечно обновлять коллекцию
        NotificationCenter.default.post(name: TrackersViewController.reloadCollection, object: self)
    }

    func getTrackerByIndexPath(at indexPath: IndexPath) -> Tracker {
        filteredtrackers[indexPath.section].trackers[indexPath.row]
    }
    
    func isTrackerCompleteForSelectedDay(trackerUUID: UUID) -> Int {
        guard let trackerRecord = trackerRecord[trackerUUID] else { return -1 }
        return trackerRecord.firstIndex(where: { Calendar.current.isDate($0, equalTo: selectedDay, toGranularity: .day) }) ?? -1
    }
    
    func resetCurrentTracker() {
        newTracker = defaultTracker
        weekDayList = defaultDayList
    }
}
