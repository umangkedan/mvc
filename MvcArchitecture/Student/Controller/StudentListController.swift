//
//  SavedStudentController.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 30/01/24.
//

import UIKit

class StudentListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var students : [Student] = []
    var studentObject = StudentObjectModel()
    var is_navigating = true
    var genericObj = GenericClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StudentCell", bundle: .main), forCellReuseIdentifier: "studentCell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchStudentDetails()
        refresh()
        setNavigationItems()
        
    }
    
    func setNavigationItems(){
        navigationItem.title = "Saved Students"
        if is_navigating {
            let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addStudent))
            navigationItem.rightBarButtonItem = addButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func addStudent() {
        let addStudentController = AddStudentController()
        addStudentController.is_navigating = true
        navigationController?.pushViewController(addStudentController, animated: true)
    }
    
    func refresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchStudentDetails()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func fetchStudentDetails() {
        let result: Result<[Student], Error> = genericObj.fetchRecords(Student.self)
        
        switch result {
        case .success(let fetchedStudents):
            students = fetchedStudents
            tableView.reloadData()
        case .failure(let error):
            print("Error fetching student details: \(error.localizedDescription)")
        }
    }

    
    func showUserAlert(title: String, meassage: String, handler:UIAlertAction){
        let alert = UIAlertController(title: title, message: meassage, preferredStyle: .alert)
        alert.addAction(handler)
        present(alert, animated: true)
    }
}

extension StudentListController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as? StudentCell
        let student = students[indexPath.row]
        let name = student.name
        let id = student.id
        var bookNames: [String] = [] // Initialize an empty array to store book names
        
        if let booksTaken = student.book_taken as? Set<Library> {
            bookNames = booksTaken.compactMap { $0.book_name }
        } else {
            print("No books taken by the student")
        }
        
        cell?.setStudentData(name: name, bookName: bookNames, Id: id)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookToDelete = students[indexPath.row]
            let deleteResult = genericObj.deleteRecord(bookToDelete)
            
            switch deleteResult {
            case .success:
                self.students.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .failure:
                print("Error deleting")
            }
        }
 }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStudent = students[indexPath.row]
        if let booksTaken = selectedStudent.book_taken as? Set<Library> {
            let booksArray = Array(booksTaken) // Convert set to array of Library objects
            if !booksArray.isEmpty {
                
                let profileController = ProfileController()
                profileController.name = selectedStudent.name
                profileController.id = String(selectedStudent.id) // Convert Int16 to String
                profileController.book = booksArray.first?.book_name
                
                navigationController?.pushViewController(profileController, animated: true)
                
                
            } else {
                print("Error: No books taken by the student")
            }
        } else {
            print("Error: Unable to cast book_taken to Set<Library>")
        }
    }
}
