//
//  StudentObject.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 29/01/24.
//

import UIKit
import CoreData

class StudentObjectModel: NSObject {
    

    func addStudent(id: Int16, name: String, books: [Library]) -> (Bool,String,String) {
        let student = Student(context: DatabaseManager.shared.context ?? NSManagedObjectContext())
        student.id = id
        student.name = name

        let booksSet = student.mutableSetValue(forKey: "book_taken")
        booksSet.addObjects(from: books)
        
        do {
            try DatabaseManager.shared.saveContext()
            return (true, "Student Added Successfully", "Student is added")
        } catch {
            print("Error while adding new Student \(error.localizedDescription)")
        }
        return (false, "Student Failed to add", "Error while adding Student")
    }
    
    func isEmptyTextField(textField: UITextField?) -> (Bool,String,String){
            if textField?.text?.isEmpty == true {
                return (true, "Empty TextField", "Cannot continue with empty TextFiled")
            }
            return (false, " ", " ")
        }
    
}



