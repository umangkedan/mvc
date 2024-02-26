//
//  HomeController.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 29/01/24.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var addStudentButton: UIButton!
    @IBOutlet weak var fetchStudent: UIButton!
    
    @IBOutlet weak var fetchBooks: UIButton!
    @IBOutlet weak var addBookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    @IBAction func addBookAction(_ sender: Any) {
        let addBookController = AddBookController()
        navigationController?.pushViewController(addBookController, animated: true)
        
    }
    
    @IBAction func addStudentAction(_ sender: Any) {
        let addStudentController = AddStudentController()
        self.navigationController?.pushViewController(addStudentController, animated: true)
    }
    
    @IBAction func fetchStudentAction(_ sender: Any) {
        let savedStudentController = StudentListController()
        self.navigationController?.pushViewController(savedStudentController, animated: true)
    }
    
    @IBAction func fetchBooksAction(_ sender: Any) {
        let savedBooks = SavedBooksController()
        navigationController?.pushViewController(savedBooks, animated: true)
    }
    
    

}


