//
//  ProfileViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 05.12.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nomPrenomLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modifProfSeg" {
            let destination = segue.destination as! ModifierProfileViewController
            destination.user = user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeProfile()
    }
    
    func initializeProfile()  {
        UserViewModel.sharedInstance.getCurrentUser { [self] success, userFromRep in
            user = userFromRep
            
            nomPrenomLabel.text = user!.firstName + " " + user!.lastName
            emailLabel.text = user!.email
            adresseLabel.text = user!.phoneNumber
            
            ImageLoader.shared.loadImage(identifier: user!.profilePicture!, url: HOST_IMAGES + (user?.profilePicture)!) { image in
                userImage.image = image
            }
        }
    }
    
    @IBAction func modifierProfil(_ sender: Any) {
        performSegue(withIdentifier: "modifProfSeg", sender: user)
    }
    
}
