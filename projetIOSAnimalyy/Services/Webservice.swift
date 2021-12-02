//
//  Webservice.swift
//  projetIOSAnimalyy
//
//  Created by User on 29.11.2021.
//

import Foundation

enum AuthentificationError: Error {
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



class Webservice {
    var NodeUrl = urlNode()
    
    //result is the token or error
    func login(email: String , mdp: String, completion: @escaping (Result<String, AuthentificationError>) -> Void ){
        
        guard let url = URL(string: NodeUrl.url + "login") else {
            completion(.failure(.custom(errorMessage: "Url is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, mdp: mdp)
        print(body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
       
        
        //perform the request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
        
            guard let data = data , error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(LoginResponseBody.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
                
            }
            completion(.success(token))
            
            
        }.resume() //to get the data
        
        
        
    }
}
    
