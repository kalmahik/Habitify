//
//  ActionsHelper.swift
//  Habitify
//
//  Created by kalmahik on 31.05.2024.
//

import UIKit

func makeAction(_ title: String, _ isDestructive: Bool, _ handler: @escaping UIActionHandler) -> UIAction {
    UIAction(
        title: title,
        image: nil,
        identifier: nil,
        discoverabilityTitle: nil,
        attributes: isDestructive ? .destructive : [],
        state: .off,
        handler: handler
    )
}
