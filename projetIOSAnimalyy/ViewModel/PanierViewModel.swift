//
//  PanierViewModel.swift
//  peddler
//
//  Created by Apple Esprit on 2/12/2021.
//
import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation

public class PanierViewModel: ObservableObject{
    
    static let sharedInstance = PanierViewModel()
    
    func getMy(completed: @escaping (Bool, Panier?) -> Void) {
        AF.request(HOST + "panier/get-my",
                   method: .post,
                   parameters: [
                    "user": UserDefaults.standard.string(forKey: "id")!
                   ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { [self] response in
                switch response.result {
                case .success:
                    completed(true, makePanier(jsonItem: JSON(response.data!)["panier"]))
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func addToCart(idProduit: String, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "panier/add-to-cart",
                   method: .post,
                   parameters: [
                    "produit": idProduit,
                    "user": UserDefaults.standard.string(forKey: "id")!
                   ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func delete(panier: Panier, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "panier",
                   method: .delete,
                   parameters: [ "_id": panier._id! ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func makePanier(jsonItem: JSON) -> Panier {
        var produits: [Produit] = []
        for produitJson in jsonItem["produits"] {
            produits.append(ProduitViewModel.sharedInstance.makeProduit(jsonItem: produitJson.1))
        }
        
        return Panier(
            _id: jsonItem["_id"].stringValue,
            produits: produits,
            user: UserViewModel.sharedInstance.makeUser(jsonItem: jsonItem["user"])
        )
    }
}
