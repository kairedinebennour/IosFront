//
//  SignUpViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 30.11.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //var
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var CIN: UITextField!
    
    
    @IBAction func inscriptionButton(_ sender: UIButton) {
        
        user = User(firstName: FirstName.text!, lastName: lastName.text!, cin: CIN.text!, email: email.text!, address: "", password: password.text!, phoneNumber: phoneNumber.text!, role: "User")
        
        UserViewModel.sharedInstance.register(user: user!) { [self] success in
            if success {
                self.performSegue(withIdentifier: "cnxSegue", sender: user)
            }
        }
        
    }
}
