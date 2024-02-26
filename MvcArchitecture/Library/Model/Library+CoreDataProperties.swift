//
//  Library+CoreDataProperties.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 31/01/24.
//
//

import Foundation
import CoreData


extension Library {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Library> {
        return NSFetchRequest<Library>(entityName: "Library")
    }

    @NSManaged public var author_name: String?
    @NSManaged public var book_name: String?
    @NSManaged public var id: Int16
    @NSManaged public var isSelected: Bool
    @NSManaged public var book_alotted: NSSet?

}

// MARK: Generated accessors for book_alotted
extension Library {

    @objc(addBook_alottedObject:)
    @NSManaged public func addToBook_alotted(_ value: Student)

    @objc(removeBook_alottedObject:)
    @NSManaged public func removeFromBook_alotted(_ value: Student)

    @objc(addBook_alotted:)
    @NSManaged public func addToBook_alotted(_ values: NSSet)

    @objc(removeBook_alotted:)
    @NSManaged public func removeFromBook_alotted(_ values: NSSet)

}

extension Library : Identifiable {

}
