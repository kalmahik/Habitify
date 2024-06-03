//
//  LoginModel.swift
//  Habitify
//
//  Created by kalmahik on 22.05.2024.
//

import Foundation

final class CategoryModel {
    private let store = Store.shared
    private let trackerManager = TrackerManager.shared

    var categories: [TrackerCategory] {
        store.getCategories(withTrackeers: false)
    }

    func getCurrentCateegoryName() -> String {
        trackerManager.tracker.categoryName
    }

    func createCategory(categoryName: String) {
        store.createСategory(with: categoryName)
    }

    func changeCategory(categoryName: String?) {
        trackerManager.changeCategory(categoryName: categoryName)
    }

}
