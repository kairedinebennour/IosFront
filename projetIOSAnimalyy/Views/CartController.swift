//
//  Accueil.swift
//  peddler
//
//  Created by Mac-Mini-2021 on 15/11/2021.
//

import UIKit
import Braintree

class CartController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    /// PAYPAL ACC
    /// sb-cfoeh10964933@personal.example.com
    /// T8!H]vN0
    
    //var
    var amount: Float = 0.0
    var braintreeClient: BTAPIClient!
    var panierAct: Panier?
    var produits: [Produit] = []
    var currentProduit : Produit?
    
    //widget
    @IBOutlet weak var produitsTV: UITableView!
    @IBOutlet weak var totalPrice: UITextView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cv = cell.contentView
        
        let produitImage = cv.viewWithTag(1) as! UIImageView
        let nomProduitLabel = cv.viewWithTag(2) as! UILabel
        let prixProduitLabel = cv.viewWithTag(3) as! UILabel
        
        let produit = produits[indexPath.row]
        
        nomProduitLabel.text = produit.name
        prixProduitLabel.text = String(produit.price) + " DT"
        
        ImageLoader.shared.loadImage(identifier: produit.imagePath, url: HOST_IMAGES + produit.imagePath) { image in
            produitImage.image = image
        }
        
        return cell
    }
    
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        braintreeClient = BTAPIClient(authorization: "sandbox_tvy2hq3d_787bfdhzq2d76fg2")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializePaniersTV()
    }
    
    func initializePaniersTV()  {
        amount = 0.0
        PanierViewModel.sharedInstance.getMy { [self] success, panierFromRep in
            if success {
                panierAct = panierFromRep
                produits = panierFromRep!.produits
                
                print(produits)
                
                var prixTOTO: Float = 0.0
                for produit in produits {
                    prixTOTO += produit.price
                }
                amount = prixTOTO
                totalPrice.text = String(prixTOTO)
                
                produitsTV.reloadData()
            }
        }
    }
    
    @IBAction func removeAll(_ sender: Any) {
        if panierAct != nil {
            if produits.count > 1 {
                self.present(Alert.makeActionAlert(titre: "Confirmation", message: "Voulez vous vraiment vider votre panier", action: UIAlertAction(title: "Oui", style: .destructive, handler: { [self] acct in
                    
                    PanierViewModel.sharedInstance.delete(panier: panierAct!) { [self] success in
                        initializePaniersTV()
                    }
                })), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Alerte", message: "Panier vide"),animated: true)
            }
            
        } else {
            self.present(Alert.makeAlert(titre: "Alerte", message: "Panier vide"),animated: true)
        }
        
        
    }
    
    
    @IBAction func paypal(_ sender: Any) {
        
        if amount > 0 {
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self // Optional
            // Specify the transaction amount here. "2.32" is used in this example.
            
            let request = BTPayPalRequest(amount: String(amount))
            request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
            
            payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                    print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                    
                    // Access additional information
                    let email = tokenizedPayPalAccount.email
                    debugPrint(email)
                    let firstName = tokenizedPayPalAccount.firstName
                    let lastName = tokenizedPayPalAccount.lastName
                    let phone = tokenizedPayPalAccount.phone
                    
                    // See BTPostalAddress.h for details
                    let billingAddress = tokenizedPayPalAccount.billingAddress
                    let shippingAddress = tokenizedPayPalAccount.shippingAddress
                    
                    self.present(Alert.makeActionAlert(titre: "Success", message: "You have successfuly bought the items",action: UIAlertAction(title: "Ok", style: .default, handler: { [self] a in
                        if panierAct != nil {
                            PanierViewModel.sharedInstance.delete(panier: panierAct!) { success in
                                initializePaniersTV()
                            }
                        } else {
                            self.present(Alert.makeAlert(titre: "Alerte", message: "Panier vide"),animated: true)
                        }
                    })),animated: true)
                    
                } else if let error = error {
                    // Handle error here...
                } else {
                    // Buyer canceled payment approval
                }
            }
        } else {
            self.present(Alert.makeAlert(titre: "Error", message: "Nothing to pay"), animated: true)
        }
        
    }
    
    
}

extension UIViewController :BTViewControllerPresentingDelegate{
    public func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    public func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
}
extension UIViewController : BTAppSwitchDelegate{
    public func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    public func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    public func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}



