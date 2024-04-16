//
//  HabitConfigurationConstants.swift
//  Habitify
//
//  Created by Murad Azimov on 08.04.2024.
//

import Foundation

struct TrackerSection {
    var title: String
    var data: [Tracker]
}

let trackerList = [
    Tracker(id: UUID(), type: .regular, name: "Кошка заслонила камеру на созвоне", color: "#FD4C49FF", emoji: "🙂", schedule:"schedule"),
    Tracker(id: UUID(), type: .regular, name: "Why are you gay?", color: "#FD4C49FF", emoji: "😻", schedule:"schedule"),
    Tracker(id: UUID(), type: .regular, name: "Бабушка прислала открытку в вотсапе", color: "#2FD058FF", emoji: "🥦", schedule:"schedule"),
    Tracker(id: UUID(), type: .regular, name: "Свидания в апреле", color: "#FD4C49FF", emoji: "🍔", schedule:"schedule"),
]

let trackerCollectionData: [TrackerSection] = [
    TrackerSection(title: "123", data: trackerList),
    TrackerSection(title: "456", data: trackerList),
    TrackerSection(title: "789", data: trackerList),
    TrackerSection(title: "101", data: trackerList),
]
