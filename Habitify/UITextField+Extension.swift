//
//  UITextField+Extension.swift
//  Habitify
//
//  Created by Murad Azimov on 10.04.2024.
//

import UIKit

extension UITextField {
    func setLeftPadding(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
