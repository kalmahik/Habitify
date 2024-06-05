//
//  Filter.swift
//  Habitify
//
//  Created by kalmahik on 05.06.2024.
//

import Foundation

enum Filter: String, CaseIterable {
    case all = "filterAll"
    case today = "filterToday"
    case finished = "filterFinished"
    case unfinished = "filterUnfinished"
}
