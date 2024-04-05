//
//  Dish+CoreDataProperties.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 16/3/2024.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var category: String?
    @NSManaged public var dishDescription: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var title: String?

}

extension Dish: Identifiable {
    
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        
        for item in menuItems {
            let dishExist = exist(title: item.title, context) ?? false

            if !dishExist {
                let dish = Dish(context: context)
                dish.title = item.title
                dish.price = item.price
                dish.image = item.image
                dish.dishDescription = item.description
                dish.category = item.category
                dish.id = Int64(item.id)
            }
        }

        guard context.hasChanges else { return }
        Dish.save(context)
    }
    
    static func exist(title: String, _ context: NSManagedObjectContext) -> Bool? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return nil
            }
            return results.count > 0
        } catch (let error){
//            print(error.localizedDescription)
            return false
        }
    }
    
    static func countRecords(_ context: NSManagedObjectContext) -> Int {
        let request = Dish.request()
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return 0
            }
            return results.count
        } catch (let error){
//            print(error.localizedDescription)
            return 0
        }
    }

    static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }

    class func deleteAll(_ context:NSManagedObjectContext) {
        let request = Dish.request()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
            save(context)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    static func save(_ context:NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
}

