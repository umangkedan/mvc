//
//  Student+CoreDataProperties.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 31/01/24.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var id: Int16
    @NSManaged public var is_Selected: Bool
    @NSManaged public var name: String?
    @NSManaged public var book_taken: NSSet?

}

// MARK: Generated accessors for book_taken
extension Student {

    @objc(addBook_takenObject:)
    @NSManaged public func addToBook_taken(_ value: Library)

    @objc(removeBook_takenObject:)
    @NSManaged public func removeFromBook_taken(_ value: Library)

    @objc(addBook_taken:)
    @NSManaged public func addToBook_taken(_ values: NSSet)

    @objc(removeBook_taken:)
    @NSManaged public func removeFromBook_taken(_ values: NSSet)

}

extension Student : Identifiable {

}
