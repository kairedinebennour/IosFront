//
//  ProfileViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 05.12.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        modifierProfileLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(modifierProfileLabelClicked(_:)))
        modifierProfileLabel.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var modifierProfileLabel: UILabel!
    
   
    
    @objc func modifierProfileLabelClicked(_ sender: Any) {
        performSegue(withIdentifier: "mSegue6", sender: sender)
    
    
    
}
}
