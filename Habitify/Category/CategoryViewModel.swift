//
//  CategoryViewModel.swift
//  Habitify
//
//  Created by kalmahik on 22.05.2024.
//

import UIKit

typealias Binding<T> = (T) -> Void

final class CategoryViewModel {
    var isEmptyState: Binding<Bool>?
    
    private let trackerManager = TrackerManager.shared
    
    func getCategoriesCount() -> Int {
        trackerManager.categories.count
    }
    
    func didDoneTapped() {
        self.dismiss(animated: true)
        self.trackerManager.updateCategoriesUI()
    }  
    
    func didAddCategoryTapped() {
        self.present(CategoryCreationViewController().wrapWithNavigationController(), animated: true)
    }
    
    func getSelectedCategoryIndexPath() -> IndexPath? {
        let index = trackerManager.categories.firstIndex { $0.title == trackerManager.newTracker.categoryName }
        guard let index else { return nil }
        let indexPath = IndexPath(row: index, section: 0)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let category = trackerManager.categories[indexPath.row]
        trackerManager.changeCategory(categoryName: category.title)
    }
    
    func setupCell(cell: CategoryCell, indexPath: IndexPath) {
        let category = trackerManager.categories[indexPath.row]
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == trackerManager.categories.count - 1
        categoryCell.setupCell(category: category, isFirst: isFirstCell, isLast: isLastCell)
    }
}
