//
//  ProfileViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 05.12.2021.
//

import UIKit

class ProfileViewController: UIViewController {
     
    var user: User = User() 

    override func viewDidLoad() {
        super.viewDidLoad()
        getAccount()
        modifierProfileLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(modifierProfileLabelClicked(_:)))
        modifierProfileLabel.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var modifierProfileLabel: UILabel!
    @IBOutlet weak var nomPrenomLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    
    func getAccount(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else{
            return
        }
        
        Webservice().getOneAccount(token: token){ (result) in
            switch result{
                case .success(let json):
                DispatchQueue.main.async {
                    self.nomPrenomLabel.text = json.nomprenom
                    self.emailLabel.text = json.email
                    self.adresseLabel.text = json.adresse
                }
              
              
                
                
             
                
                
                
                
                
             
                
           
                
             
                    

                
              
                
            case .failure(let err):
            print(err.localizedDescription)
            
        }
    }
    }
   
    
    @objc func modifierProfileLabelClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "mSegue6", sender: sender)
    
       
}
}
