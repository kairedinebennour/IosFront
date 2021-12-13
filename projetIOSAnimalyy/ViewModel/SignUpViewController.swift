//
//  SignUpViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 30.11.2021.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nomPrenomTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var mdpTextField: UITextField!
    
    @IBOutlet weak var adresseTextField: UITextField!
    
    
    @IBAction func inscriptionButton(_ sender: UIButton) {
        guard let nomprenom = self.nomPrenomTextField.text else { return }
        guard let email = self.emailTextField.text else { return  }
        guard let mdp = self.mdpTextField.text else { return  }
        guard let adresse = self.adresseTextField.text else { return  }
        
        
        Webservice().registerUser(email: email, mdp: mdp, adresse: adresse, localisation: "", nomprenom: nomprenom, pdp: "", role: "client") { (result) in
                switch result{
                    case .success(let json):
                    print(json as AnyObject)
                    case .failure(let err):
                    print(err.localizedDescription)
            }
        }
        
        
        
        
    
    }
            
       
          
    
    
    
    
    /*
     @IBAction func emailTextField(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
