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
//        subview.layer.borderWidth = 1
        addSubview(subview)
    }
    
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
