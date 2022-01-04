//
//  FavorisViewController.swift
//  projetIOSAnimalyy
//
//  Created by Apple Mac on 4/1/2022.
//

import Foundation
import UIKit

class FavorisViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var
    var produits: [Produit] = []
    
    //widget
    @IBOutlet weak var favorisTV: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cv = cell.contentView
        
        let favoriImage = cv.viewWithTag(1) as! UIImageView
        let nomfavoriLabel = cv.viewWithTag(2) as! UILabel
        let prixfavoriLabel = cv.viewWithTag(3) as! UILabel
        let favoriButton = cv.viewWithTag(4) as! UIButton
        
        var newFavArray = UserDefaults.standard.array(forKey: "favoriteProd") as! [String]
        
        let produit = produits[indexPath.row]
        
        favoriButton.addAction(UIAction(handler: { [self] UIAction in
            
            newFavArray.removeAll(where: { value in  return value == produit._id! })
            UserDefaults.standard.set(newFavArray, forKey: "favoriteProd")
            
            initializePaniersTV()
            
        }), for: .touchUpInside)
        
        
        nomfavoriLabel.text = produit.name
        prixfavoriLabel.text = String(produit.name)
        
        ImageLoader.shared.loadImage(identifier: produit.imagePath, url: HOST_IMAGES + produit.imagePath) { image in
            favoriImage.image = image
        }
        
        return cell
    }
    
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializePaniersTV()
    }
    
    func initializePaniersTV()  {
        ProduitViewModel.sharedInstance.getAll { [self] success, produitsFromResp in
            if success {
                produits = []
                
                for produit in produitsFromResp! {
                    if UserDefaults.standard.array(forKey: "favoriteProd") != nil {
                        
                        let favoritesArray = UserDefaults.standard.array(forKey: "favoriteProd") as! [String]
                        if favoritesArray.contains(produit._id!){
                            produits.append(produit)
                        }
                    }
                }
                
                favorisTV.reloadData()
            }
        }
    }
}
