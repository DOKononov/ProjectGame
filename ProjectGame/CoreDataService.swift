//
//  CoreDataService.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 30.01.22.
//

import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() { }
    
     var managadObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
     var persistentContainer: NSPersistentCloudKitContainer = {

        let container = NSPersistentCloudKitContainer(name: "ProjectGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
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
}
