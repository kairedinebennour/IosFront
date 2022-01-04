//
//  DetailsViewController.swift
//  peddler
//
//  Created by iMac on 23/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //var
    var produit: Produit?

    //widgets
    @IBOutlet weak var produitImage: UIImageView!
    @IBOutlet weak var produitNameLabel: UILabel!
    @IBOutlet weak var informationLabel: UITextView!
    @IBOutlet weak var prixLABEL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        produitNameLabel.text = produit?.name
        prixLABEL.text = String((produit?.price)!) + " DT"
        //informationLabel.text = "Infos : " + produit!.information
        
        ImageLoader.shared.loadImage(identifier: produit!.imagePath, url: HOST_IMAGES + produit!.imagePath) { image in
            self.produitImage.image = image
        }
    }
    
    @IBAction func addToCart(_ sender: Any) {
        PanierViewModel.sharedInstance.addToCart(idProduit: (produit?._id)!) { success in
            if success {
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Added to cart !",action: UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in
                    self.dismiss(animated: true, completion: nil)
                })),animated: true)
            }
        }
    }
}
