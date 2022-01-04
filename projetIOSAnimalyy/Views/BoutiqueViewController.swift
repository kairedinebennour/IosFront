//
//  home.swift
//  peddler
//
//  Created by Mac-Mini-2021 on 12/12/2021.
//

import UIKit

class BoutiqueViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //var
    var produits: [Produit] = []
    var currentProduit : Produit?
    
    //widget
    @IBOutlet weak var produitCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let cv = cell.contentView
        let produitImage = cv.viewWithTag(1) as! UIImageView
        let produitNamelabel = cv.viewWithTag(2) as! UILabel
        let produitPrixlabel = cv.viewWithTag(3) as! UILabel
        let buttonLike = cv.viewWithTag(4) as! UIButton
        
        let produit = produits[indexPath.row]
        
        if UserDefaults.standard.array(forKey: "favoriteProd") != nil {
            
            print(UserDefaults.standard.array(forKey: "favoriteProd")!)
            
            let favArray = UserDefaults.standard.array(forKey: "favoriteProd") as! [String]
            
            if favArray.contains(produit._id!){
                buttonLike.tintColor = UIColor.red
            } else {
                buttonLike.tintColor = UIColor.black
            }
            
        } else {
            buttonLike.tintColor = UIColor.black
        }
        
        buttonLike.addAction(UIAction(handler: { action in
            
            if UserDefaults.standard.array(forKey: "favoriteProd") != nil {
                
                print("case 1")
                var newFavArray = UserDefaults.standard.array(forKey: "favoriteProd") as! [String]
                
                if newFavArray.contains(produit._id!){
                    buttonLike.tintColor = UIColor.label
                    newFavArray.removeAll(where: { value in  return value == produit._id! })
                    UserDefaults.standard.set(newFavArray, forKey: "favoriteProd")
                    print("case 2")
                } else {
                    buttonLike.tintColor = UIColor.red
                    newFavArray.append(produit._id!)
                    UserDefaults.standard.set(newFavArray, forKey: "favoriteProd")
                    print("case 3")
                }
                
            } else {
                print("case 4")
                buttonLike.tintColor = UIColor.red
                UserDefaults.standard.set([produit._id], forKey: "favoriteProd")
            }
            
        }), for: .touchDown)
        
        ImageLoader.shared.loadImage(identifier: produit.imagePath, url: HOST_IMAGES + produit.imagePath) { image in
            produitImage.image = image
        }
        
        produitNamelabel.text = produit.name
        produitPrixlabel.text = String(produit.price)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let produitName = produits[indexPath.row].name
        currentProduit = produits[indexPath.row]
        performSegue(withIdentifier: "mSegue", sender: produitName)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mSegue" {
            let destination = segue.destination as! DetailsViewController
            destination.produit = currentProduit
        }
    }
    
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        produits = []
        
        produitCollectionView.reloadData()
        
        initializeProduitsTV()
    }
    
    func initializeProduitsTV()  {
        ProduitViewModel.sharedInstance.getAll { [self] success, produitsFromRep in
            if success {
                produits = produitsFromRep!
                
                produitCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        
    }
}
