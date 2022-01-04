//
//  LoginViewModel.swift
//  projetIOSAnimalyy
//
//  Created by User on 29.11.2021.
//

import Foundation

class LoginViewModel : ObservableObject {
    
    var email: String = ""
    var mdp: String = ""
    
    func login(){
    Webservice().login(email: email, mdp: mdp){ result in
        
        print(self.email)
        print(self.mdp)
        
      
     
     switch result {
     case .success(let token):
         print(token)
     case .failure(let error):
         print(error.localizedDescription)
     }
 }
}
}
