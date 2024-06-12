//
//  Analytics.swift
//  Habitify
//
//  Created by kalmahik on 06.06.2024.
//

import AppMetricaCore
import Foundation

enum Event: String {
    case open, close, click
}

enum Screen: String {
    case Main, Creation, Category
}

enum Item: String {
    case addTrack = "add_track"
    case track = "track"
    case filter = "filter"
    case edit = "edit"
    case delete = "delete"
}

func sendEvent(event: Event, screen: Screen, item: Item?) {
    var params: [AnyHashable: Any] = ["screen": screen.rawValue]
    if let item {
        params["item"] = item.rawValue
    }
    AppMetrica.reportEvent(name: event.rawValue, parameters: params)
}
