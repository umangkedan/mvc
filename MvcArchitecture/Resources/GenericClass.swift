//
//  GenericClass.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 20/02/24.
//

import UIKit
import CoreData

class GenericClass: NSObject {

    let context = DatabaseManager.shared.context
    
    func deleteRecord<T: NSManagedObject>(_ record: T) -> Result<Void, Error> {
        guard let context = record.managedObjectContext else {
            return .failure(CoreDataError.noContext)
        }
        
        context.delete(record)
        do {
            try context.save()
            return .success(())
        } catch {
            print("Error deleting object: \(error.localizedDescription)")
            return .failure(error)
        }
    }
   
    func fetchRecords<T: NSManagedObject>(_ entityType: T.Type) -> Result<[T], Error> {
        if context == context {
            let fetchRequest = T.fetchRequest()
            do {
                let records = try context!.fetch(fetchRequest) as? [T] ?? []
                return .success(records)
            } catch {
                print("Error fetching objects: \(error.localizedDescription)")
                return .failure(error)
            }
        }
        return .failure("No data" as! Error)
    }
}

enum CoreDataError: Error {
    case noContext
}
