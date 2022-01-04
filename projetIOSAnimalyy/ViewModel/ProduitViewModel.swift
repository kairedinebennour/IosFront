//
//  ProduitViewModel.swift
//  peddler
//
//  Created by Apple Esprit on 2/12/2021.
//
import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class ProduitViewModel: ObservableObject{
    
    static let sharedInstance = ProduitViewModel()
    
    func getAll(completed: @escaping (Bool, [Produit]?) -> Void) {
        AF.request(HOST + "produit",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var produits : [Produit] = []
                    for produit in JSON(response.data!)["produits"] {
                        produits.append(ProduitViewModel.sharedInstance.makeProduit(jsonItem: produit.1))
                    }
                    completed(true, produits)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func add(produit: Produit, uiImage: UIImage, completed: @escaping (Bool) -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [
                        "name": produit.name,
                        "price": String(produit.price),
                        "marge": produit.marge,
                        "information": produit.information
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: HOST + "produit",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    completed(false)
                    print(error)
                }
            }
    }
    
    func edit(produit: Produit, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "produit",
                   method: .put,
                   parameters: [
                    "_id": produit._id!,
                    "name": produit.name,
                    "price": produit.price,
                    "marge": produit.marge,
                    "information": produit.information
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
    
    func delete(produit: Produit, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "produit",
                   method: .delete,
                   parameters: [ "_id": produit._id! ],
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
    
    func makeProduit(jsonItem: JSON) -> Produit {
        Produit(
            _id: jsonItem["_id"].stringValue,
            name: jsonItem["name"].stringValue,
            imagePath: jsonItem["imagePath"].stringValue,
            price: jsonItem["price"].floatValue,
            marge: jsonItem["marge"].stringValue,
            information: jsonItem["information"].stringValue
        )
    }
}
