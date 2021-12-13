//
//  ModifierProfileViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 13.12.2021.
//

import UIKit

class ModifierProfileViewController: UIViewController {

    override func viewDidLoad() {
        getAccount()
        viewWillAppear(true)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nomPrenomTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var adresseTextField: UITextField!
    
    @IBAction func mettreAJourButton(_ sender: UIButton) {
        guard let nomprenom = self.nomPrenomTextField.text else { return }
        guard let email = self.emailTextField.text else { return  }
        guard let adresse = self.adresseTextField.text else { return  }
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else{
            return
        }
        
        Webservice().updateUser(token: token, email: email, adresse: adresse, localisation: "", nomprenom: nomprenom, pdp: "") { (result) in
                switch result{
                    case .success(let json):
                    print("User updated successfully!")
                    print(json as AnyObject)
                    case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
        
        
        
        
        
        
    
    
    
    func getAccount(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else{
            return
        }
        
        Webservice().getOneAccount(token: token){ (result) in
            switch result{
                case .success(let json):
                DispatchQueue.main.async {
                    self.nomPrenomTextField.text = json.nomprenom
                    self.emailTextField.text = json.email
                    self.adresseTextField.text = json.adresse
                }
                case .failure(let err):
                print(err.localizedDescription)
                
            }
        }
        
        
        
        
    }
}

