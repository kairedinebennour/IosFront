//
//  UserModel.swift
//  projetIOSAnimalyy
//
//  Created by User on 16.11.2021.
//

import Foundation

struct User: Decodable  {
    
    internal init(_id: String? = nil, firstName: String, lastName: String, cin: String, email: String, address: String, password: String, phoneNumber: String, profilePicture: String? = nil, isVerified: Bool? = nil, role: String) {
        self._id = _id
        self.firstName = firstName
        self.lastName = lastName
        self.cin = cin
        self.email = email
        self.address = address
        self.password = password
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
        self.isVerified = isVerified
        self.role = role
    }
    
    var _id: String?
    var firstName: String
    var lastName: String
    var cin: String
    var email: String
    var address: String
    var password: String
    var phoneNumber: String
    var profilePicture: String?
    var isVerified: Bool?
    var role: String
}
