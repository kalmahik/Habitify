//
//  RootViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class RootViewController: UIViewController {
    let settingsStore = SettingsStore()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    // MARK: - Configure

    private func configureViewController() {
        let rootController: UIViewController
        if settingsStore.isOnbordingWasShown {
            rootController = TabBarViewController()
        } else {
            var onboardingVC = OnboardingViewController()
            onboardingVC.didCompleteTapped = switchToApp
            rootController = onboardingVC
        }
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController = rootController
    }

    func switchToApp() {
        settingsStore.setOnboardingShown()
        let rootController = TabBarViewController()
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController = rootController
    }
}
