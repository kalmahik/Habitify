//
//  CategoryViewModel.swift
//  Habitify
//
//  Created by kalmahik on 22.05.2024.
//

import Foundation

typealias Binding<T> = (T) -> Void

final class CategoryViewModel {
    var isEmptyStateBinding: Binding<Bool>?
    var categoriesBinding: Binding<[TrackerCategory]>?

    private let model: CategoryModel

    init(for model: CategoryModel) {
        self.model = model
    }

    func didDoneTapped() {
        updateCreationUI()
    }

    func loadCategories() {
        categoriesBinding?(model.categories)
        isEmptyStateBinding?(model.categories.isEmpty)
        updateCategoriesUI()
    }

    func getSelectedCategoryIndexPath() -> IndexPath? {
        let index = model.categories.firstIndex { $0.title == model.getCurrentCateegoryName() }
        guard let index else { return nil }
        return IndexPath(row: index, section: 0)
    }

    func didSelectRowAt(indexPath: IndexPath) {
        let category = model.categories[indexPath.row]
        model.changeCategory(categoryName: category.title)
    }

    func createCategory(categoryName: String) {
        model.createCategory(categoryName: categoryName)
        loadCategories()
    }

    func setupCell(cell: CategoryCell, indexPath: IndexPath) {
        let category = model.categories[indexPath.row]
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == model.categories.count - 1
        cell.setupCell(category: category, isFirst: isFirstCell, isLast: isLastCell)
    }

    private func updateCreationUI() {
        NotificationCenter.default.post(name: TrackerCreationViewController.reloadCollection, object: self)
    }

    private func updateCategoriesUI() {
        NotificationCenter.default.post(name: CategoriesViewController.reloadCollection, object: self)
    }
}
