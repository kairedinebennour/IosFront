//
//  UserModel.swift
//  projetIOSAnimalyy
//
//  Created by User on 16.11.2021.
//

struct User: Identifiable, Decodable, Equatable {

    var id : Int
    var email : String
    var mdp: String
    var nomprenom : String
    var adresse : String
    var localisation : String
    var role: String
    var pdp: String

}