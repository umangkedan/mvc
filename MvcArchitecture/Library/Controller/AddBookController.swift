//
//  addBookController.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 29/01/24.
//

import UIKit
import CoreData

class AddBookController: UIViewController {

    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var bookIdTextField: UITextField!
    @IBOutlet weak var authorNameTextField: UITextField!

    let libraryObject = LibraryObjectModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitAction(_ sender: Any) {
        guard let bookIdText = bookIdTextField.text, !bookIdText.isEmpty,
              let bookName = bookNameTextField.text, !bookName.isEmpty else {
            print("Error: Book ID or Book Name is empty or unable to get managed object context")
            return
        }
        // Convert bookId to Int16
        guard let bookId = Int16(bookIdText) else {
            print("Error: Invalid Book ID format")
            return
        }
        
        let authorName = authorNameTextField.text // Author name may be nil
        
        do {
            try libraryObject.addBooks(id: bookId, name: bookName, author: authorName)
        } catch {
            print("Error adding book: \(error)")
        }
    }
}
