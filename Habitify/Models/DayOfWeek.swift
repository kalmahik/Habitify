//
//  DayOfWeek.swift
//  Habitify
//
//  Created by kalmahik on 18.04.2024.
//

import Foundation

enum DayOfWeek: String, CaseIterable {
    case monday = "Пн",
         tuesday = "Вт",
         wednesday = "Ср",
         thursday = "Чт",
         friday = "Пт",
         saturday = "Сб",
         sunday = "Вс"

    var shortName: String {
        switch self {
            case .monday:     return "Пн"
            case .tuesday:    return "Вт"
            case .wednesday:  return "Ср"
            case .thursday:   return "Чт"
            case .friday:     return "Пт"
            case .saturday:   return "Сб"
            case .sunday:     return "Вс"
        }
    }

    var fullName: String {
        switch self {
            case .monday:    return "Понедельник"
            case .tuesday:   return "Вторник"
            case .wednesday: return "Среда"
            case .thursday:  return "Четверг"
            case .friday:    return "Пятница"
            case .saturday:  return "Суббота"
            case .sunday:    return "Воскресенье"
        }
    }

    static func scheduleToString(schedule: [DayOfWeekSchedule]) -> String {
        if schedule.filter({ $0.isEnabled }).count == 7 {
            return NSLocalizedString("scheduleEveryday", comment: "")
        }
        let hasNotWeekend = schedule
            .filter { $0.isEnabled }
            .map { $0.dayOfWeek }
            .filter { $0 == DayOfWeek.saturday || $0 == DayOfWeek.sunday }
            .isEmpty
        if schedule.filter({ $0.isEnabled }).count == 5 && hasNotWeekend {
            return NSLocalizedString("scheduleWorkingDay", comment: "")
        }
        return schedule
            .filter { $0.isEnabled }
            .map { $0.dayOfWeek.shortName }
            .joined(separator: ", ")
    }

    static func stringToSchedule(scheduleString: String) -> [DayOfWeekSchedule] {
        if scheduleString.isEmpty {
            return []
        }
        if scheduleString == NSLocalizedString("scheduleEveryday", comment: "") {
            return DayOfWeek.allCases.map { DayOfWeekSchedule(dayOfWeek: $0, isEnabled: true) }
        }
        if scheduleString == NSLocalizedString("scheduleWorkingDay", comment: "") {
            return DayOfWeek.allCases[0...4].map { DayOfWeekSchedule(dayOfWeek: $0, isEnabled: true) }
        }
        return scheduleString
            .components(separatedBy: ", ")
            .map { DayOfWeekSchedule(dayOfWeek: DayOfWeek(rawValue: $0) ?? .monday, isEnabled: true) }
    }
}

struct DayOfWeekSchedule {
    static let dayOfWeekSchedule = DayOfWeek.allCases.map { DayOfWeekSchedule(dayOfWeek: $0, isEnabled: false) }

    let dayOfWeek: DayOfWeek
    var isEnabled: Bool
}
