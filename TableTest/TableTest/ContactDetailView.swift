//
//  ContactDetailView.swift
//  TableTest
//
//  Created by Joseph on 25.10.2020.
//

import UIKit

class ContactDetailViewController: UIViewController {
    var person: Person? = nil

    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    func setData(person: Person) {
        self.person = person
    }

    override func viewDidLoad() {
        self.surname.text = person?.surnname
        self.name.text = person?.name
        self.phoneNumber.text = person?.phoneNumber
    }
}
