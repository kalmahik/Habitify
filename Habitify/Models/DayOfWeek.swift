//
//  DayOfWeek.swift
//  Habitify
//
//  Created by kalmahik on 18.04.2024.
//

import Foundation

enum DayOfWeek: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday

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

    static func scheduleToString(schedule: [DayOfWeekSwitch]) -> String {
        if schedule.filter({ $0.isEnabled }).count == 7 {
            return "Каждый день"
        }
        let hasNotWeekend = schedule
            .filter { $0.isEnabled }
            .map { $0.dayOfWeek }
            .filter { $0 == DayOfWeek.saturday || $0 == DayOfWeek.sunday }
            .isEmpty
        if schedule.filter({ $0.isEnabled }).count == 5 && hasNotWeekend {
            return "Будние дни"
        }
        return schedule
            .filter { $0.isEnabled }
            .map { $0.dayOfWeek.shortName }
            .joined(separator: ", ")
    }

    static func stringToSchedule(scheduleString: String) -> [DayOfWeekSwitch] {
        if scheduleString == "Каждый день" {
            return DayOfWeek.allCases.map { DayOfWeekSwitch(dayOfWeek: $0, isEnabled: true) }
        }
        if scheduleString == "Будние дни" {
            return DayOfWeek.allCases[0...4].map { DayOfWeekSwitch(dayOfWeek: $0, isEnabled: true) }
        }
        return scheduleString
            .components(separatedBy: ", ")
            .map { DayOfWeekSwitch(dayOfWeek: DayOfWeek(rawValue: String($0)) ?? .monday, isEnabled: true)}
    }
}

struct DayOfWeekSwitch {
    let dayOfWeek: DayOfWeek
    var isEnabled: Bool
}
