//
//  UIView+Extension.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

extension UIView {
    func setupView(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}
