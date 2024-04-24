//
//  HabitConfigurationConstants.swift
//  Habitify
//
//  Created by Murad Azimov on 08.04.2024.
//

import Foundation

struct Section {
    var title: String
    var data: [String]
}

let emojiList = [
    "🙂","😻","🌺","🐶", "❤️", "😱",
    "😇","😡","🥶","🤔", "🙌", "🍔",
    "🥦","🏓","🥇","🎸", "🏝", "😪"
]

let colorList = [
    "#FD4C49FF","#FF881EFF","#007BFAFF","#6E44FEFF", "#33CF69FF", "#E66DD4FF",
    "#F9D4D4FF","#34A7FEFF","#46E69DFF","#35347CFF", "#FF674DFF", "#FF99CCFF",
    "#F6C48BFF","#7994F5FF","#832CF1FF","#AD56DAFF", "#8D72E6FF", "#2FD058FF"
]

let collectionData = [
    Section(title: "", data: [""]), //hack for the feader
    Section(title: "Emoji", data: emojiList),
    Section(title: "Цвет", data: colorList),
    Section(title: "", data: [""]), //hack for the footer
]

var newTracker = TrackerPreparation(
    id: UUID(),
    type: .regular,
    name: "",
    color: "#832CF1FF",
    emoji: "🙂",
    schedule: ""
)
