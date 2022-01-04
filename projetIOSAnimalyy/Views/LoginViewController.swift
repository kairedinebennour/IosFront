//
//  LoginViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 29.11.2021.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func buttonConnexion(_ sender: UIButton) {
        
        UserViewModel.sharedInstance.login(email: emailTF.text!, password: passwordTF.text!) { success in
            if success {
                print("you are connected")
                if UserDefaults.standard.string(forKey: "role") == "Admin" {
                    self.performSegue(withIdentifier: "AdminSegue", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                }
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Invalid credentials"), animated: true)
            }
        }
    }
}











