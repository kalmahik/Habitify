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
            case .monday: return "ПН"
            case .tuesday: return "ВТ"
            case .wednesday: return "СР"
            case .thursday: return "ЧТ"
            case .friday: return "ПТ"
            case .saturday: return "СБ"
            case .sunday: return "ВС"
        }
    }
    
    var fullName: String {
        switch self {
            case .monday: return "Понедельник"
            case .tuesday: return "Вторник"
            case .wednesday: return "Среда"
            case .thursday: return "Четверг"
            case .friday: return "Пятница"
            case .saturday: return "Суббота"
            case .sunday: return "Воскресенье"  
        }
    }
    
    static func scheduleToString(schedule: [DayOfWeekItem]) -> String {
        if schedule.filter({ $0.isEnabled }).count == 7 {
            return "Каждый день"
        }
        if schedule.filter({ $0.isEnabled }).count == 5 {
            return "Будние дни"
        }
        return schedule
            .filter { $0.isEnabled }
            .map{ $0.dayOfWeek.shortName }
            .joined(separator: ", ")
    }
    
    static func stringToSchedule(scheduleString: String) -> [DayOfWeekItem] {
        if scheduleString == "Каждый день" {
            return DayOfWeek.allCases.map { DayOfWeekItem(dayOfWeek: $0, isEnabled: true) }
        }
        if scheduleString == "Будние дни" {
            return DayOfWeek.allCases[0...4].map { DayOfWeekItem(dayOfWeek: $0, isEnabled: true) }
        }
        return scheduleString
            .components(separatedBy: ", ")
            .map { DayOfWeekItem(dayOfWeek: DayOfWeek(rawValue: String($0)) ?? .monday, isEnabled: true)}
    }
}

struct DayOfWeekItem {
    let dayOfWeek: DayOfWeek
    var isEnabled: Bool
}
