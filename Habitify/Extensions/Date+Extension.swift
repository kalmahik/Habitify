//
//  Date+Extension.swift
//  Habitify
//
//  Created by Murad Azimov on 01.05.2024.
//

import Foundation

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale =  Locale(identifier: "en")
        return dateFormatter.string(from: self).lowercased()
    }
}
