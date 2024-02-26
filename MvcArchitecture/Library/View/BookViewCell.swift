//
//  BookViewCell.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 29/01/24.
//

import UIKit

class BookViewCell: UITableViewCell {
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    var indexPath: IndexPath?
    var selectedLibrary: Library?
    var selectedBooks: [Library] = []
    var bookSelectionDelegate: BookSelectionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkButton.isHidden = true
        checkButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setBookData( library: Library , isCheckMarkHidden: Bool = true ){
        selectedLibrary = library
        bookNameLabel.text = library.book_name
        authorNameLabel.text = "Author- \(library.author_name ?? "")"
        
        checkButton.isHidden = isCheckMarkHidden
        
    }
    
    func setStudentData(name : String?){
        bookNameLabel.text = name
        authorNameLabel.isHidden = true
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
      //  selectedLibrary?.isSelected = sender.isSelected
        
        guard let selectedLibrary = selectedLibrary else { return }
        
        if sender.isSelected {
            selectedLibrary.isSelected = sender.isSelected
            checkButton.isSelected = sender.isSelected
            selectedBooks.append(selectedLibrary)
            
        } else {
            selectedLibrary.isSelected = !sender.isSelected
            checkButton.isSelected = !sender.isSelected
            if let index = selectedBooks.firstIndex(where: { $0 === selectedLibrary }) {
                selectedBooks.remove(at: index)
            }
        }
        bookSelectionDelegate?.updateBookTextField()
    }
}
