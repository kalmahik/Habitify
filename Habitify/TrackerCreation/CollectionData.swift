//
//  CollectionData.swift
//  Habitify
//
//  Created by Murad Azimov on 08.04.2024.
//

import Foundation

struct Section {
    var title: String
    var data: [String]
}

let collectionData = [
    Section(title: "", data: [""]), // hack for the feader
    Section(title: "Emoji", data: emojiList),
    Section(title: "Цвет", data: colorList),
    Section(title: "", data: [""]) // hack for the footer
]
