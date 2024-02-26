//
//  ProfileController.swift
//  MvcArchitecture
//
//  Created by Umang Kedan on 01/02/24.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var name : String?
    var id : String?
    var book : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Student Details"
        
        bookLabel.text = " Book - \(book ?? "")"
        idLabel.text = "ID - \(id ?? "")"
        nameLabel.text = name
    }
    
}
