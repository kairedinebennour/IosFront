//
//  LoginViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 29.11.2021.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
   
    
    let defaults = UserDefaults.standard
    @Published var isAuthenticated: Bool = false // change property get notification
    
    
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldMdp: UITextField!
    
   
   
    @IBAction func buttonConnexion(_ sender: UIButton) {
        guard let email = self.textFieldEmail.text else { return  }
        guard let mdp = self.textFieldMdp.text else { return  }
        
        Webservice().login(email: email, mdp: mdp){ result in
        
            print(email)
            print(mdp)
          
         
         switch result {
         case .success(let token):
             self.defaults.setValue(token, forKey: "jsonwebtoken")
             
             DispatchQueue.main.async {
                 self.isAuthenticated = true
                    
                 
             }
         case .failure(let error):
             print(error.localizedDescription)
         }
            
     }
        if(isAuthenticated == true){
            print("hello")
            performSegue(withIdentifier: "mSegue5", sender: sender)
        }
        
    
    }
    
    }
       
    
    
    
    
    
    
    
    


    
