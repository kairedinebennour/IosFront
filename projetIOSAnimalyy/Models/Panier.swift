//
//  File.swift
//  projetIOSAnimalyy
//
//  Created by Apple Mac on 4/1/2022.
//

import Foundation

struct Panier {
    
    internal init(_id: String? = nil, produits: [Produit], user: User) {
        self._id = _id
        self.produits = produits
        self.user = user
    }
    
    var _id: String?
    var produits: [Produit]
    var user: User
}
