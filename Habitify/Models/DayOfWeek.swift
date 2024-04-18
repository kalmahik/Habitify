//
//  DayOfWeek.swift
//  Habitify
//
//  Created by kalmahik on 18.04.2024.
//

import Foundation

enum DayOfWeek: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    var shortName: String {
        switch self {
            case .sunday: return "ВС"
            case .monday: return "ПН"
            case .tuesday: return "ВТ"
            case .wednesday: return "СР"
            case .thursday: return "ЧТ"
            case .friday: return "ПТ"
            case .saturday: return "СБ"
        }
    }
    
    var fullName: String {
        switch self {
            case .sunday: return "Воскресенье"
            case .monday: return "Понедельник"
            case .tuesday: return "Вторник"
            case .wednesday: return "Среда"
            case .thursday: return "Четверг"
            case .friday: return "Пятница"
            case .saturday: return "Суббота"
        }
    }
}
