//
//  AddStudentController.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 29/01/24.
//

import UIKit
import CoreData

class AddStudentController: UIViewController {
    
    @IBOutlet weak var cutButton: UIButton!
    @IBOutlet weak var studentIdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var chooseBookTextField: UITextField!
    
    let studentObject = StudentObjectModel()
    var selectedBooks: [Library] = []
    var is_navigating : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
        tapGesture()
        
    }
    func tapGesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(authorNameTextFieldTapped))
        chooseBookTextField.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func authorNameTextFieldTapped() {
        let savedBooksController = SavedBooksController(nibName: "SavedBooksController", bundle: nil)
            savedBooksController.bookSelectionDelegate = self  // Set the delegate
            navigationController?.pushViewController(savedBooksController, animated: true)
            savedBooksController.is_selected = false
    }
    
    func showUserAlert(title: String, meassage: String, handler:UIAlertAction){
        let alert = UIAlertController(title: title, message: meassage, preferredStyle: .alert)
        alert.addAction(handler)
        present(alert, animated: true)
    }
    
    func checkTextFeilds() -> Bool{
        let ok = UIAlertAction(title: "ok", style: .default)
            let nameText = studentObject.isEmptyTextField(textField: nameTextField)
            let idText = studentObject.isEmptyTextField(textField: studentIdTextField )
            
            if nameText.0 == true {
                showUserAlert(title: nameText.1, meassage: nameText.2, handler: ok)
                return false
            } else if idText.0 == true {
                showUserAlert(title: idText.1, meassage: idText.2, handler: ok)
                return false
            } else {
                return true
            }
        }
    
    @IBAction func submitAction(_ sender: Any) {
        
        if checkTextFeilds() == true {
            let addStudent = studentObject.addStudent(id: Int16(studentIdTextField.text ?? "") ?? 0, name: nameTextField.text!, books: selectedBooks)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: {_ in
                if addStudent.0 == true {
                    print("Student added successfully!")
                    let libraryOBJ = LibraryObjectModel()
                    libraryOBJ.resetOBJLib(librarry: self.selectedBooks)
                    self.navigationController?.popViewController(animated: true)
                    self.resetTextFields()
                }
            })
            showUserAlert(title: addStudent.1, meassage: addStudent.2, handler: ok)
        }
    }
    
    func resetTextFields() {
        studentIdTextField.text = ""
        nameTextField.text = ""
        chooseBookTextField.text = ""
    }
    
    @IBAction func cutButtonAction(_ sender: Any) {
        guard !selectedBooks.isEmpty else {
            return
        }
        // Remove the last selected book from the array
        selectedBooks.removeLast()
        
        // Update the text field to display the remaining selected books
        let bookNames = selectedBooks.map { $0.book_name ?? "" }.joined(separator: ", ")
        chooseBookTextField.text = bookNames
    }
}

extension AddStudentController: BookSelectionDelegate {
    func didSelectBook(_ book: [Library]) {
        selectedBooks = book
        updateBookTextField()
    }
  
    func updateBookTextField() {
        let selectedBooks = selectedBooks.map { "\($0.book_name ?? "") " }
        chooseBookTextField.text = selectedBooks.joined(separator: ", ")
        
    }
}

    


