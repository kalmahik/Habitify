//
//  Store.swift
//  Habitify
//
//  Created by kalmahik on 06.05.2024.
//

import CoreData
import UIKit

final class Store: NSObject {
    public static let shared = Store()
    
    public var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    func createTracker(with tracker: Tracker, and categoryName: String) {
        let trackerEntity = TrackerCoreData(context: context)
        trackerEntity.id = tracker.id
        trackerEntity.name = tracker.name
        trackerEntity.emoji = tracker.emoji
        trackerEntity.color = tracker.color
        trackerEntity.schedule = tracker.schedule
        
        let categoryEntity = createСategory(with: categoryName)
        categoryEntity.addToTrackers(trackerEntity)
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func getCategories() -> [TrackerCategory] {
        let fetchCategoryRequest: NSFetchRequest<TrackerCategoryCoreData> = TrackerCategoryCoreData.fetchRequest()
        do {
            let categoryEntities = try context.fetch(fetchCategoryRequest)
            return categoryEntities.map { TrackerCategory(title: $0.title ?? "", trackers: getTrackers(by: $0))}
        } catch let error as NSError {
            print(error.userInfo)
            return []
        }
    }
    
    private func getTrackers(by category: TrackerCategoryCoreData) -> [Tracker] {
        let fetchRequest: NSFetchRequest<TrackerCoreData> = TrackerCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)

        do {
            let trackerEntities = try context.fetch(fetchRequest)
            let trackers = trackerEntities.map { Tracker(from: $0) }
            return trackers
        } catch let error as NSError {
            print(error.userInfo)
            return []
        }
    }
    
    // создаем категорию. Если категория уже существует - то не создаем новую
    private func createСategory(with categoryName: String) -> TrackerCategoryCoreData {
        if let existedCategory = getCategory(by: categoryName) {
            //TODO: find out the best way to handle existed category
            return existedCategory
        }
        let categoryEntity = TrackerCategoryCoreData(context: context)
        categoryEntity.title = categoryName
        do {
            try context.save()
            return categoryEntity
        }
        catch let error as NSError {
            print(error.userInfo)
            return categoryEntity
        }
    }
    
    private func getCategory(by name: String) -> TrackerCategoryCoreData? {
        let fetchRequest: NSFetchRequest<TrackerCategoryCoreData> = TrackerCategoryCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", name)
        do {
            guard let category = try context.fetch(fetchRequest).first else {
                return nil
            }
            return category
        }
        catch let error as NSError {
            print(error.userInfo)
            return nil
        }
    }
}
