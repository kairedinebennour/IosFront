//
//  ModifierProfileViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 13.12.2021.
//

import UIKit

class ModifierProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: User?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var cinTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
    }
    
    func initialize() {
        
        ImageLoader.shared.loadImage(identifier: user!.profilePicture!, url: HOST_IMAGES + (user?.profilePicture)!) { [self] image in
            userImage.image = image
        }
        
        nomTextField.text = user?.firstName
        prenomTextField.text = user?.lastName
        telephoneTextField.text = user?.phoneNumber
        cinTF.text = user?.cin
    }
    
    @IBAction func mettreAJourButton(_ sender: UIButton) {
        
        user = User(firstName: nomTextField.text!, lastName: prenomTextField.text!, cin: cinTF.text!, email: "", address: "", password: "", phoneNumber: telephoneTextField.text!, profilePicture: "", isVerified: true, role: "")
        
        UserViewModel.sharedInstance.updateProfile(user: user!) { success in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                
            }
        }
    }
    
    //Action-------------------------------------------------------
    @IBAction func addImage(_ sender: Any) {
        showPhotoAlert()
    }
    
    func showPhotoAlert(){
        let alert = UIAlertController(title: "Take Photo From", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action
            in
            self.getPhoto(type: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {action
            in
            self.getPhoto(type: .photoLibrary)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert,animated: true)
    }
    
    func getPhoto (type : UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("image not found")
            return
        }
        
        UserViewModel.sharedInstance.editProfilePicture(email: user!.email, uiImage: image) { [self] success in
            if success {
                userImage.image = image
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

