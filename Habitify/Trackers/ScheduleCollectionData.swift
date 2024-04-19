//
//  ScheduleCollectionData.swift
//  Habitify
//
//  Created by Murad Azimov on 08.04.2024.
//

import Foundation

struct DayOfWeekItem {
    let dayOfWeek: DayOfWeek
    let isEnabled: Bool
}

let scheduleCollectionData = [
    DayOfWeekItem(dayOfWeek: .monday, isEnabled: false),
    DayOfWeekItem(dayOfWeek: .tuesday, isEnabled: false),
    DayOfWeekItem(dayOfWeek: .wednesday, isEnabled: false),
    DayOfWeekItem(dayOfWeek: .thursday, isEnabled: false),
    DayOfWeekItem(dayOfWeek: .friday, isEnabled: false),
    DayOfWeekItem(dayOfWeek: .saturday, isEnabled: false),
    DayOfWeekItem(dayOfWeek: .sunday, isEnabled: false),
]
