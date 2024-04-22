//
//  HabitConfigurationConstants.swift
//  Habitify
//
//  Created by Murad Azimov on 08.04.2024.
//

import Foundation

private var trackerList = [
    Tracker(id: UUID(), type: .regular, name: "Кошка заслонила камеру на созвоне", color: "#FD4C49FF", emoji: "🙂", schedule:"schedule"),
    Tracker(id: UUID(), type: .regular, name: "Why are you gay?", color: "#FD4C49FF", emoji: "😻", schedule:"schedule"),
    Tracker(id: UUID(), type: .regular, name: "Бабушка прислала открытку в вотсапе", color: "#2FD058FF", emoji: "🥦", schedule:"schedule"),
    Tracker(id: UUID(), type: .regular, name: "Свидания в апреле", color: "#FD4C49FF", emoji: "🍔", schedule:"schedule"),
]

var trackerCollectionData: [TrackerCategory] = [
    TrackerCategory(title: "123", trackers: trackerList),
    TrackerCategory(title: "456", trackers: trackerList),
    TrackerCategory(title: "789", trackers: trackerList),
    TrackerCategory(title: "101", trackers: trackerList),
]

var categories: [TrackerCategory] = []
