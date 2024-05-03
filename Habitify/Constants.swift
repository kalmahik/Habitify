//
//  Constants.swift
//  Habitify
//
//  Created by kalmahik on 26.04.2024.
//

import UIKit

struct Insets {
    static let horizontalInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    static let emptyInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    static let fullInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
}

struct Config {
    static let trackerCellHeight: CGFloat = 148
    static let trackerSpaceBetweenCells: CGFloat = 8
}

let emojiList = [
    "🙂", "😻", "🌺", "🐶", "❤️", "😱",
    "😇", "😡", "🥶", "🤔", "🙌", "🍔",
    "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
]

let colorList = [
    "#FD4C49FF", "#FF881EFF", "#007BFAFF", "#6E44FEFF", "#33CF69FF", "#E66DD4FF",
    "#F9D4D4FF", "#34A7FEFF", "#46E69DFF", "#35347CFF", "#FF674DFF", "#FF99CCFF",
    "#F6C48BFF", "#7994F5FF", "#832CF1FF", "#AD56DAFF", "#8D72E6FF", "#2FD058FF"
]

let trackersMockData = [
    TrackerCategory(
        title: "123",
        trackers: [
//            Tracker(
//                id: UUID(uuidString: "6D70BB77-169C-4058-B2F1-01C6A79C6E38")!,
//                type: .regular,
//                name: "Будние дни",
//                color: "#FF881EFF",
//                emoji: "🙂",
//                schedule: "Будние дни"
//            ),
//            Tracker(
//                id: UUID(uuidString: "2CBDA97A-58BD-458E-9BA3-897C15A72E21")!,
//                type: .regular,
//                name: "Каждый день",
//                color: "#FD4C49FF",
//                emoji: "🙂",
//                schedule: "Каждый день"
//            ),
            Tracker(
                id: UUID(uuidString: "776302AD-9F40-4C84-B102-4B9FE8449039")!,
                type: .regular,
                name: "Пн, Ср, Пт",
                color: "#007BFAFF",
                emoji: "🙂",
                schedule: "Пн, Ср, Пт"
            )
        ]
    ),
]
