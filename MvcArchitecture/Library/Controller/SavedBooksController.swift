
//  SavedBooksController.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 29/01/24.
//

import UIKit

protocol BookSelectionDelegate: AnyObject {
    func didSelectBook(_ book: [Library])
    func updateBookTextField()
}

class SavedBooksController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var books: [Library] = []
    var selectedStudent: Student?
    let libraryObject = LibraryObjectModel()
    var is_selected = true
    var selectedBook: Library?
    var selectedBooks: [Library] = []
    weak var bookSelectionDelegate: BookSelectionDelegate?
    let studentModel = StudentObjectModel()
    let genericObj = GenericClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BookViewCell", bundle: .main), forCellReuseIdentifier: "bookCell")
        navigationItem.title = "Books"
        fetchBooksFromCoreData()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        if is_selected == false {
            navigationItem.rightBarButtonItem = doneButton
        }
    }
    
    @objc func doneButtonTapped() {
        let updatedBooksArr = libraryObject.updateBooks(librarry: books, students: selectedStudent)
        bookSelectionDelegate?.didSelectBook(updatedBooksArr)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func fetchBooksFromCoreData() {
        let result: Result<[Library], Error> = genericObj.fetchRecords(Library.self)
        
        switch result {
        case .success(let fetchedBooks):
            books = fetchedBooks
            tableView.reloadData()
        case .failure(let error):
            print("Error fetching books: \(error.localizedDescription)")
        }
    }
}

extension SavedBooksController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookViewCell else {
            return UITableViewCell()
        }
        
        let book = books[indexPath.row]
        cell.setBookData(library: book, isCheckMarkHidden: is_selected)
        cell.bookSelectionDelegate = self
        
        cell.checkButton.isSelected = selectedBooks.contains(book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) as? BookViewCell {
            selectedBooks.append(selectedBook) // Add the book to selectedBooks
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookToDelete = books[indexPath.row]
            let deleteResult = genericObj.deleteRecord(bookToDelete)
            
            switch deleteResult {
            case .success:
                self.books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .failure:
                print("Error deleting")
            }
        }
    }
}

extension SavedBooksController: BookSelectionDelegate {
    func didSelectBook(_ book: [Library]) {
        bookSelectionDelegate?.didSelectBook(book)
    }
    
    func updateBookTextField() {
        bookSelectionDelegate?.updateBookTextField()
    }
    
}

