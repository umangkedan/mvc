//
//  StudentCell.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 30/01/24.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    var student : Student?
    var is_selected = true
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.setImage(UIImage(named: "square"), for: .normal)
        checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBoxButton.isHidden = !is_selected
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setStudentData(name:String? , bookName : [String] , Id : Int16 , isCheckMarkHiden: Bool = true){
        nameLabel.text = name
        bookNameLabel.text = bookName.joined(separator: ", ")
        idLabel.text = "\(Id)"
        checkBoxButton.isHidden = true
    }
    
    func setBookData(bookName : String? , isCheckMarkHiden: Bool = true  ){
        bookNameLabel.text = bookName
        nameLabel.isHidden = true
        idLabel.isHidden = true
        checkBoxButton.isHidden = true
        
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let student = student {
            student.is_Selected = sender.isSelected
            
        }
    }
}
