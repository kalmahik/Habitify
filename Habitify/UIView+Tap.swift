//
//  UIView.swift
//  Habitify
//
//  Created by Murad Azimov on 10.04.2024.
//

import UIKit

extension UIView {
    
    func addTapGesture(_ action : @escaping ()->Void ){ 
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        guard let action = sender.action else { return }
        action()
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}
