//
//  TouchableView.swift
//  Habitify
//
//  Created by Murad Azimov on 10.04.2024.
//

import UIKit

class TouchableView: UIButton {
    // Custom button class for touch handling
    
    // You can add properties or methods here if needed
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configure touch handling
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        // Handle touch event here
        print("Button tapped!")
    }
}
