//
//  UIViewController+Extension.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

extension UIViewController {
    func wrapWithNavigationController() -> UINavigationController {
        UINavigationController(rootViewController: self)
    }
}
