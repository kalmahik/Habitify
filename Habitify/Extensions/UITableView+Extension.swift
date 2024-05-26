//
//  UITableView+Extension.swift
//  Habitify
//
//  Created by kalmahik on 16.04.2024.
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ emoji: String, _ title: String) {
        let emptyView = EmptyView(emoji: emoji, title: title)
        self.backgroundView = emptyView
    }

    func restore() {
        self.backgroundView = nil
    }
}
