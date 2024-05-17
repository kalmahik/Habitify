//
//  Pages.swift
//  Habitify
//
//  Created by kalmahik on 17.05.2024.
//

import Foundation

enum Pages: Int, CaseIterable {
    case pageZero = 0, pageOne
    
    var name: String {
        switch self {
        case .pageZero:
            return NSLocalizedString("onboardingTitleOne", comment: "")
        case .pageOne:
            return NSLocalizedString("onboardingTitleTwo", comment: "")
        }
    }
}
