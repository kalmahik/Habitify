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

enum LocalizedStrings {
    static let trackersTitle = "Трекеры"
    static let trackersEmpty = "Что будем отслеживать?"
    static let statisticsEmpty = "Анализировать пока нечего"
    static let dateFormat = "dd.MM.yyyy"
    static let cancelButton = "Отменить"
    static let creationButton = "Создать"
    static let trackerNamePlaceholder = "Введите название трекера"
    static let categoryButton = "Категория"
    static let schduleButton = "Расписание"
    static let trackerRegularType = "Новая привычка"
    static let trackerSingleType = "Новое нерегулярное событие"
    static let trackerRegularTypeButton = "Привычка"
    static let trackerSingleTypeButton = "Нерегулярное событие"
    static let trackerType = "Создание трекера"
    static let trackersTab = "Трекеры"
    static let statisticsTab = "Статистика"
    static let doneButton = "Готово"
    static let scheduleTitle = "Расписание"
    static let trackerNameLengthError = "Ограничение 38 символов"
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
