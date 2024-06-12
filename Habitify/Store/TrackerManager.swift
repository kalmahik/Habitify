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
    private(set) var filters: [Filter] = Filter.allCases
    private(set) var filter: Filter = Filter.all
    private(set) var tracker: TrackerPreparation = .emptyTracker
    private let store = Store.shared

    // MARK: - Tracker list properties

    var categories: [TrackerCategory] {
        store.getCategories(withTrackers: false)
    }

    // тут получаем все трекеры, и первыми ставим запиненные
    var trackers: [TrackerCategory] {
        var pinnedTrackers: [Tracker] = []
        let pinnedCategoryName = NSLocalizedString("pinnedCategory", comment: "")
        var categories = store.getCategories(withTrackers: true).map {
            TrackerCategory(
                title: $0.title,
                trackers: $0.trackers
                    .filter {
                        // exclude pinned trackers and collect them
                        if $0.categoryName == pinnedCategoryName {
                            pinnedTrackers.append($0)
                            return false
                        }
                        return true
                    }
            )
        }
        let pinnedCategory = TrackerCategory(title: pinnedCategoryName, trackers: pinnedTrackers)
        categories.insert(pinnedCategory, at: 0)
        return categories
    }

    // мне кажется эту фильтрацию лучше перенести на сторону кор даты, оставим на десерт
    var filteredTrackers: [TrackerCategory] {
        let categories = trackers.map {
            TrackerCategory(
                title: $0.title,
                trackers: $0.trackers
                    .filter {
                        // allow single events
                        if $0.schedule.isEmpty { return true }
                        // check day of week
                        let scheduleArray = DayOfWeek.stringToScheduleArray($0.schedule)
                        let selectedDayOfWeek = selectedDay.dayOfWeek()
                        return scheduleArray.contains(selectedDayOfWeek)
                    }.filter {
                        switch filter {
                        case .all:
                            return true
                        case .today:
                            return true
                        case .finished:
                            return isTrackerCompletedForSelectedDay(trackerId: $0.id)
                        case .unfinished:
                            return !isTrackerCompletedForSelectedDay(trackerId: $0.id)
                        }
                    }
            )
        }
        // убираем категории без трекеров
        return categories.filter { !$0.trackers.isEmpty }
    }

    // MARK: - Creation properties

    var isRegular: Bool { tracker.type == .regular }

    var isEditing: Bool { tracker.id != nil }

    var isValid: Bool {
        !tracker.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        (isRegular ? !tracker.schedule.isEmpty : true) &&
        !tracker.emoji.isEmpty &&
        !tracker.color.isEmpty &&
        !tracker.categoryName.isEmpty
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
        self.tracker.type = trackerType
    }

    func changeName(name: String?) {
        tracker.name = name ?? ""
        updateCreationUI()
    }

    func applySchedule() {
        tracker.schedule = DayOfWeek.scheduleToString(weekDayList)
        updateCreationUI()
    }

    func changeSelectedSchedules(indexPath: IndexPath) {
        let weekDay = weekDayList[indexPath.row]
        weekDayList[indexPath.row].isEnabled = !weekDay.isEnabled
    }

    func changeEmoji(emoji: String?) {
        self.tracker.emoji = emoji ?? ""
        updateCreationUI()
    }

    func changeColor(color: String?) {
        self.tracker.color = color ?? ""
        updateCreationUI()
    }

    func changeCategory(categoryName: String?) {
        self.tracker.categoryName = categoryName ?? ""
    }

    func createTracker() {
        let tracker = Tracker(from: tracker)
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

    func deleteTracker(with indexPath: IndexPath) {
        let tracker = getTracker(by: indexPath)
        store.deleteTracker(with: tracker.id)
        updateTrackersUI()
    }

    func applyFilter(indexPath: IndexPath) {
        filter = filters[indexPath.row]
        if filter == .today {
            resetDatePicker()
            changeSelectedDay(selectedDay: Date())
        } else {
            updateTrackersUI()
        }
    }

    func getIndexPathOfFilter() -> IndexPath {
        IndexPath(item: filters.firstIndex { $0 == filter } ?? 0, section: 0)
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

    func resetDatePicker() {
        // а есть более удачный способ сбрасывать пикер?
        NotificationCenter.default.post(name: TrackersViewController.resetDatePicker, object: self)
    }

    func getTracker(by indexPath: IndexPath) -> Tracker {
        filteredTrackers[indexPath.section].trackers[indexPath.row]
    }

    func getCategory(by indexPath: IndexPath) -> TrackerCategory {
        categories[indexPath.section]
    }

    func isTrackerCompletedForSelectedDay(trackerId: UUID) -> Bool {
        let records = store.getRecords(by: trackerId)
        return records.first { Calendar.current.isDate($0.date, equalTo: selectedDay, toGranularity: .day) } != nil
    }

    func getTrackerCount(trackerId: UUID) -> Int {
        store.getRecords(by: trackerId).count
    }

    func getTrackersCount() -> Int {
        store.getAllTrackers().count
    }

    func getRecordsCount() -> Int {
        store.getAllRecords().count
    }

    func resetCurrentTracker(_ tracker: Tracker? = nil, _ categoryName: String?) {
        weekDayList = DayOfWeekSchedule.dayOfWeekSchedule
        if let tracker {
            self.tracker = TrackerPreparation(from: tracker)
        } else {
            self.tracker = .emptyTracker
        }
        changeCategory(categoryName: categoryName)
    }
}
