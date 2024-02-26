//
//  LibraryObject.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 29/01/24.
//

import UIKit
import CoreData

class LibraryObjectModel: NSObject {
    static let managedObjectContext: NSManagedObjectContext = {
        guard let appDelegate = DatabaseManager.shared.appDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    func addBooks(id: Int16, name: String, author: String?) throws {
        let newBook = Library(context: LibraryObjectModel.managedObjectContext)
        newBook.id = id
        newBook.book_name = name
        newBook.author_name = author
        
        do {
            try LibraryObjectModel.managedObjectContext.save()
            print("Book added successfully!")
        } catch {
            print("Error adding book: \(error)")
            throw error
        }
    }

    

    func updateBooks(librarry:[Library]=[], students:Student?) -> [Library] {
        var libraryArr:[Library] = []
        
        if let library = students?.book_taken as? Set<Library> {
            libraryArr = Array(library)
        }
        
        for library in librarry {
            if library.isSelected == true {
                libraryArr.append(library)
            }
        }
        return libraryArr
    }
    
    func resetOBJLib(librarry:[Library]=[]) {
        for library in librarry {
            if library.isSelected == true {
                library.isSelected = false
            }
        }
    }
}

