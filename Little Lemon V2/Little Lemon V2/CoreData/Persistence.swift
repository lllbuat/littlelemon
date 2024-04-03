import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Little_Lemon_V2")
//        container = NSPersistentContainer(name: "ExampleDatabase")
//        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores {_,_ in }
//        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
//    func clear() {
//        // Delete all dishes from the store
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
////        save()
//    }
//    
//    func save() {
//        guard container.viewContext.hasChanges else { return }
//        do {
//            try container.viewContext.save()
//        } catch let error as NSError {
//            print("Unresolved error \(error), \(error.userInfo)")
//        }
//    }
}
