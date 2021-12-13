//
//  Webservice.swift
//  projetIOSAnimalyy
//
//  Created by User on 29.11.2021.
//

import Foundation

enum Errors: Error {
    case invalidCredentials
    case bitch
    case messin
    case custom(errorMessage: String)
}


struct LoginRequestBody: Codable {
    let email: String
    let mdp: String
}

struct LoginResponseBody: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}
enum ApiErros: Error{
    case custom(message: String)
}
typealias Handler = (Swift.Result<Any?, ApiErros>) -> Void
typealias UserHandler = (Swift.Result<(User), Error>) -> Void

class Webservice {
    var NodeUrl = urlNode()
       

    //result is the token or error
    func login(email: String , mdp: String, completionHandler : @escaping Handler){
        
        let parametres = ["email": email , "mdp": mdp]
        
        guard let url = URL(string: NodeUrl.url + "users/login") else { return }
        
        //let body = LoginRequestBody(email: email, mdp: mdp)
        //print(body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parametres, options: [])
        //request.httpBody = try? JSONEncoder().encode(body)
       
        
        //perform the request
        URLSession.shared.dataTask(with: request){ data,response,error in
            if let error = error {
                completionHandler(.failure(.custom(message: "Pls")))
            }
            else{
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options:  []) as? [String : Any]
                completionHandler(.success(jsonRes))
                
            }
        }.resume() //to get the data
        
        
    }
    
    
    func registerUser(email: String , mdp: String,adresse: String,localisation: String,nomprenom: String,pdp:String, role: String,  completionHandler : @escaping Handler ){
        
        let parametres = ["email": email , "mdp": mdp, "nomprenom":nomprenom, "adresse":adresse,"localisation":"","pdp":"","role":"client"]
        
        guard let url = URL(string: NodeUrl.url + "users/register") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parametres, options: [])
        
        URLSession.shared.dataTask(with: request){ data,response,error in
            if let error = error {
                completionHandler(.failure(.custom(message: "Pls")))
            }
            else{
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options:  [])
                completionHandler(.success(jsonRes))
                
            }
            
        }.resume()
    }
        
        
        
    
    
    func getOneAccount(token: String, completionHandler : @escaping UserHandler) {
        
        guard let url = URL(string: NodeUrl.url + "users/token") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ data,response,error in
            guard let data = data , error == nil else {
                          return
           }
            
            guard let jsonRes = try? JSONDecoder().decode(User.self, from: data) else {
                return}
            
            completionHandler(.success(jsonRes))
        }.resume()
        
            
            
    }
    
    
    func updateUser(token:String, email: String ,adresse: String,localisation: String,nomprenom: String,pdp:String ,  completionHandler : @escaping Handler ){
        
        let parametres = ["email": email , "nomprenom":nomprenom, "adresse":adresse,"localisation":"","pdp":""]
        
        guard let url = URL(string: NodeUrl.url + "users/update") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parametres, options: [])
        
        URLSession.shared.dataTask(with: request){ data,response,error in
            if let error = error {
                completionHandler(.failure(.custom(message: "Pls")))
            }
            else{
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options:  [])
                completionHandler(.success(jsonRes))
               
                
            }
            
        }.resume()
    }
}
    

    
    
    
    
    
    
    
    
    
    
    
    
        
        
        
        
        
        
        
        
        
    

