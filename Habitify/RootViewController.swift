//
//  RootViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class RootViewController: UIViewController {

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    // MARK: - Configure

    private func configureViewController() {
//        let tabBarController = TabBarViewController()
        let tabBarController = OnboradingViewController()
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController = tabBarController
    }
}
