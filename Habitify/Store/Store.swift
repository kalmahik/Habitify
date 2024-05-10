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
}

final class TrackerStore: NSObject {
    public static let shared = TrackerStore()
    
    public var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    func createTracker(with tracker: Tracker) {
        let trackerEntity = TrackerCoreData(context: context)
        
        trackerEntity.id = tracker.id
        trackerEntity.name = tracker.name
        trackerEntity.emoji = tracker.emoji
        trackerEntity.color = tracker.color
        trackerEntity.schedule = tracker.schedule
        
        let categoryEntity = TrackerCategoryCoreData(context: context)
        categoryEntity.title = "Главное"
        categoryEntity.addToTrackers(trackerEntity)
                
        do {
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func getTrackers() -> [Tracker] {
        let fetchRequest: NSFetchRequest<TrackerCoreData> = TrackerCoreData.fetchRequest()
        do {
            let trackerEntities = try context.fetch(fetchRequest)
            let trackers = trackerEntities.map { Tracker(from: $0) }
//            print(trackers)
            return []
        } catch let error as NSError {
            print(error.userInfo)
            return []
        }
    }
}

class TrackerCategoryStore: NSObject {
    public static let shared = TrackerCategoryStore()
    
    public var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    func createСategory(with categoryName: String) -> TrackerCategoryCoreData {
        if let existedCategory = getCategory(by: categoryName) {
            //TODO: find out the best way to handle existed category
            return existedCategory
        }
        let categoryEntity = TrackerCategoryCoreData(context: context)
        categoryEntity.title = categoryName
//        categoryEntity.addToTrackers(T##value: TrackerCoreData##TrackerCoreData)
//        categoryEntity.trackers = NSSet(object: tracker)
        do {
            try context.save()
            return categoryEntity
        }
        catch let error as NSError {
            print(error.userInfo)
            return categoryEntity
        }
    }
    
    func                                                              getCategories() -> [TrackerCategory] {
        let fetchRequest: NSFetchRequest<TrackerCategoryCoreData> = TrackerCategoryCoreData.fetchRequest()
        do {
            let categoryEntities = try context.fetch(fetchRequest)
            let categories = categoryEntities.map { TrackerCategory(from: $0) }
            return categories
        } catch let error as NSError {
            print(error.userInfo)
            return []
        }
    }
    
    func getCategory(by name: String) -> TrackerCategoryCoreData? {
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

class TrackerRecordStore {
    func makeRecord(trackerUUID: UUID) {}
}
