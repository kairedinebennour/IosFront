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
 
    
    
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldMdp: UITextField!
    
   
   
    @IBAction func buttonConnexion(_ sender: UIButton) {
        guard let email = self.textFieldEmail.text else { return  }
        guard let mdp = self.textFieldMdp.text else { return  }
        
        Webservice().login(email: email, mdp: mdp){ (result) in
            switch result{
                case .success(let json):
                let token = (json as AnyObject).value(forKey: "token") as! String
                
                self.defaults.setValue(token, forKey: "jsonwebtoken")
                
                //let user = (json as AnyObject).value(forKey: "user")
                //print("this is user ", user)
                //let id = (user as AnyObject).value(forKey: "nomprenom") as! String
                //print("this is nomprenom ", id)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "mSegue5", sender: sender)
                }
                
                
                case .failure(let err):
                print(err.localizedDescription)
        }
    }
    }
}
    
    
    
    
    
    
    
    


    
