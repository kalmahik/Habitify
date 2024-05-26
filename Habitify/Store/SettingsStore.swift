//
//  SettingsStore.swift
//  Habitify
//
//  Created by Murad Azimov on 19.05.2024.
//

import Foundation

final class SettingsStore {
    let defaults = UserDefaults.standard

    var isOnbordingWasShown: Bool {
        defaults.bool(forKey: "onboardingWasShown")
    }
    
    func setOnboardingShown() {
        defaults.set(true, forKey: "onboardingWasShown")
    }
}
