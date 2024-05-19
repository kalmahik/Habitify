//
//  Store.swift
//  Habitify
//
//  Created by kalmahik on 06.05.2024.
//

import CoreData
import UIKit

protocol StoreProtocol {
    var context: NSManagedObjectContext { get }
}

final class Store: NSObject, StoreProtocol {
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    public static let shared = Store()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Habitify")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private override init() {}
    
    func createTracker(with tracker: Tracker, and categoryName: String) {
        let trackerEntity = TrackerCoreData(context: context)
        trackerEntity.id = tracker.id
        trackerEntity.name = tracker.name
        trackerEntity.emoji = tracker.emoji
        trackerEntity.color = tracker.color
        trackerEntity.schedule = tracker.schedule
        trackerEntity.createdAt = Date()
        
        let categoryEntity = createСategory(with: categoryName)
        categoryEntity.addToTrackers(trackerEntity)
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    func getCategories() -> [TrackerCategory] {
        let fetchRequest: NSFetchRequest<TrackerCategoryCoreData> = TrackerCategoryCoreData.fetchRequest()
        do {
            let categoryEntities = try context.fetch(fetchRequest)
            return categoryEntities.map {
                let trackers = $0.trackers?
                    .map { Tracker(from: $0 as! TrackerCoreData) }
                    .sorted { $0.createdAt < $1.createdAt }
                return TrackerCategory(title: $0.title ?? "", trackers: trackers ?? [])
            }
        } catch let error as NSError {
            print(error.userInfo)
            return []
        }
    }
    
    func makeRecord(with trackerId: UUID, at date: Date) {
        // берем все записи
        let records = getRecords(of: trackerId)
        // проверяем если уже есть запись навыбранный день
        let index = records.firstIndex { Calendar.current.isDate($0.date ?? Date(), equalTo: date, toGranularity: .day) } ?? -1
        // если запись есть
        if index > 0 {
            // то удаляем ее
            context.delete(records[index])
        } else {
            // иначе создаем
            let recordEntity = TrackerRecordCoreData(context: context)
            recordEntity.id = trackerId
            recordEntity.date = date
        }
        do {
            try context.save()
        }
        catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    func getRecords(by trackerId: UUID) -> [TrackerRecord] {
        let fetchRequest: NSFetchRequest<TrackerRecordCoreData> = TrackerRecordCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", trackerId as CVarArg)
        do {
            let recordEntities = try context.fetch(fetchRequest)
            return recordEntities.map { TrackerRecord(from: $0)}
        }
        catch let error as NSError {
            print(error.userInfo)
            return []
        }
    }
    
    private func getRecords(of trackerId: UUID) -> [TrackerRecordCoreData] {
        let fetchRequest: NSFetchRequest<TrackerRecordCoreData> = TrackerRecordCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", trackerId as CVarArg)
        do {
            let recordEntities = try context.fetch(fetchRequest)
            return recordEntities
        }
        catch let error as NSError {
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
    
    // пока не используется
    private func getTracker(by id: UUID) -> TrackerCoreData? {
        let fetchRequest: NSFetchRequest<TrackerCoreData> = TrackerCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            guard let tracker = try context.fetch(fetchRequest).first else {
                return nil
            }
            return tracker
        }
        catch let error as NSError {
            print(error.userInfo)
            return nil
        }
    }
}
