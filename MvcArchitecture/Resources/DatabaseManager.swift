//
//  DatabaseManager.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 20/02/24.
//

import UIKit
import CoreData

class DatabaseManager: NSObject {

    static let shared = DatabaseManager()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MvcArchitecture")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext? {
        return persistentContainer.viewContext
    }
    
    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error as NSError // Throw the error instead of triggering a fatal error
            }
        }
    }
}


