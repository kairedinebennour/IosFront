//
//  AddProduitViewController.swift
//  peddler
//
//  Created by Mac-Mini-2021 on 06/12/2021.
//

import UIKit
import Foundation

class AddProduitViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //var
    var currentImage = UIImage()
    
    //widget
    @IBOutlet weak var produitName: UITextField!
    @IBOutlet weak var prix: UITextField!
    @IBOutlet weak var information: UITextField!
    @IBOutlet weak var produitImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //Action
    @IBAction func addprodImage(_ sender: Any) {
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
        
        produitImage.image = image
        currentImage = image
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Add(_ sender: Any) {
        
        if Float(prix.text!) == nil {
            self.present(Alert.makeAlert(titre: "Prix", message: "Prix should be float"),animated: true)
            return
        }
        
        let produit = Produit(name: produitName.text!, imagePath: "", price: Float(prix.text!)!, marge: "", information: information.text!)
        
        ProduitViewModel.sharedInstance.add(produit: produit, uiImage: currentImage) { (succes) in
            if succes {
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Added successfully", action: UIAlertAction(title: "Proceed", style: .default, handler: { UIAlertAction in
                    self.navigationController?.popViewController(animated: true)
                })), animated: true)
            }else{
                print("failed")
            }
        }
    }
    
}


