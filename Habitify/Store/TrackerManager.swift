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
    private(set) var weekDayList: [DayOfWeekSchedule] = DayOfWeekSchedule.dayOfWeekSchedule
    private(set) var trackerForCreation: TrackerPreparation = .emptyTracker
    private let store = Store.shared

    // MARK: - Tracker list properties

    // мне кажется эту фильрацию лучше перенести на сторону кор даты, оставим на десерт
    var filteredtrackers: [TrackerCategory] {
        var pinnedTrackers: [Tracker] = []
        let pinnedCategoryName = NSLocalizedString("pinnedCategory", comment: "")
        var categories = store.getCategories(withTrackeers: true).map {
            TrackerCategory(
                title: $0.title,
                trackers: $0.trackers.filter {
                    if $0.categoryName == pinnedCategoryName {
                        pinnedTrackers.append($0)
                        return false
                    }
                    if $0.schedule.isEmpty { return true }
                    let schedule = DayOfWeek.stringToSchedule(scheduleString: $0.schedule).map {
                        String(describing: $0.dayOfWeek)
                    }
                    let selectedDayOfWeek = selectedDay.dayOfWeek()
                    return schedule.contains(selectedDayOfWeek)
                }
            )
        }
        let pinnedCategory = TrackerCategory(title: pinnedCategoryName, trackers: pinnedTrackers)
        categories.insert(pinnedCategory, at: 0)
        return categories.filter { !$0.trackers.isEmpty }
    }

    // MARK: - Creation properties

    var isRegular: Bool { trackerForCreation.type == .regular }

    var isValid: Bool {
        !trackerForCreation.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        (isRegular ? !trackerForCreation.schedule.isEmpty : true) &&
        !trackerForCreation.emoji.isEmpty &&
        !trackerForCreation.color.isEmpty &&
        !trackerForCreation.categoryName.isEmpty
    }

    // MARK: - Tracker list methods

    func changeSelectedDay(selectedDay: Date) {
        self.selectedDay = selectedDay
        updateTrackersUI()
    }

    func makeRecord(trackerId: UUID) {
        store.makeRecord(with: trackerId, at: selectedDay)
        updateTrackersUI()
    }

    // MARK: - Creation methods

    func changeType(trackerType: TrackerType) {
        self.trackerForCreation.type = trackerType
    }

    func changeName(name: String?) {
        trackerForCreation.name = name ?? ""
        updateCreationUI()
    }

    func applySchedule() {
        trackerForCreation.schedule = DayOfWeek.scheduleToString(schedule: weekDayList)
        updateCreationUI()
    }

    func changeSelectedSchedules(indexPath: IndexPath) {
        let weekDay = weekDayList[indexPath.row]
        weekDayList[indexPath.row].isEnabled = !weekDay.isEnabled
    }

    func changeEmoji(emoji: String?) {
        self.trackerForCreation.emoji = emoji ?? ""
        updateCreationUI()
    }

    func changeColor(color: String?) {
        self.trackerForCreation.color = color ?? ""
        updateCreationUI()
    }

    func changeCategory(categoryName: String?) {
        self.trackerForCreation.categoryName = categoryName ?? ""
    }

    func createTracker() {
        let tracker = Tracker(from: trackerForCreation)
        store.createTracker(with: tracker)
        updateTrackersUI()
    }

    func pinTracker(with indexPath: IndexPath) {
        let tracker = getTracker(by: indexPath)
        store.pinTracker(with: tracker.id)
        updateTrackersUI()
    }

    func unpinTracker(with indexPath: IndexPath) {
        let tracker = getTracker(by: indexPath)
        store.unpinTracker(with: tracker.id)
        updateTrackersUI()
    }

    // MARK: - Utils

    func updateCreationUI() {
        // выглядит это не очень, т к менеджер обновляет юай, но пока оставим это тут
        NotificationCenter.default.post(name: TrackerCreationViewController.reloadCollection, object: self)
    }

    func updateTrackersUI() {
        // если трекеров много будет - то это не эффективно, лучше точечно обновлять коллекцию
        NotificationCenter.default.post(name: TrackersViewController.reloadCollection, object: self)
    }

    func updateCategoriesUI() {
        NotificationCenter.default.post(name: CategoriesViewController.reloadCollection, object: self)
    }

    func getTracker(by indexPath: IndexPath) -> Tracker {
        filteredtrackers[indexPath.section].trackers[indexPath.row]
    }

    func getCategory(by indexPath: IndexPath) -> TrackerCategory {
        filteredtrackers[indexPath.section]
    }

    func isTrackerCompleteForSelectedDay(trackerId: UUID) -> Int {
        let records = store.getRecords(by: trackerId)
        return records.firstIndex { Calendar.current.isDate($0.date, equalTo: selectedDay, toGranularity: .day) } ?? -1
    }

    func getTrackerCount(trackerId: UUID) -> Int {
        store.getRecords(by: trackerId).count
    }

    func resetCurrentTracker(_ tracker: Tracker? = nil) {
        weekDayList = DayOfWeekSchedule.dayOfWeekSchedule
        if let tracker {
            trackerForCreation = TrackerPreparation(from: tracker)
        } else {
            trackerForCreation = .emptyTracker
        }
    }
}
