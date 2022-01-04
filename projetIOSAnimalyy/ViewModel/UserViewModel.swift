//
//  UserViewModel.swift
//  peddler
//
//  Created by Apple Esprit on 2/12/2021.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class UserViewModel: ObservableObject{
    
    static let sharedInstance = UserViewModel()
    
    func register(user: User, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "user/register",
                   method: .post,
                   parameters: [
                    "firstName": user.firstName,
                    "lastName": user.lastName,
                    "cin": user.cin,
                    "email": user.email,
                    "address": user.address,
                    "password": user.password,
                    "phoneNumber": user.phoneNumber,
                    "role": user.role
                   ])
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
    
    func login(email: String, password: String, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "user/login",
                   method: .post,
                   parameters: [
                    "email": email,
                    "password": password
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { [self] response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    
                    let user = makeUser(jsonItem: JSON(response.data!)["user"])
                    
                    UserDefaults.standard.setValue(user._id, forKey: "id")
                    UserDefaults.standard.setValue(user.role, forKey: "role")
                    UserDefaults.standard.setValue(JSON(response.data!)["token"].stringValue, forKey: "token")
                    
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func loginWithSocialApp(email: String, firstName: String, lastName: String, completed: @escaping (Bool, User?) -> Void ) {
        AF.request(HOST + "user/login-with-social",
                   method: .post,
                   parameters: ["email": email, "firstName": firstName, "lastName": lastName],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeUser(jsonItem: jsonData["user"])
                    
                    print("this is the new token value : " + jsonData["token"].stringValue)
                    
                    UserDefaults.standard.setValue(user._id, forKey: "id")
                    UserDefaults.standard.setValue(user.role, forKey: "role")
                    UserDefaults.standard.setValue(JSON(response.data!)["token"].stringValue, forKey: "token")
                    
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func getCurrentUser(completed: @escaping (Bool, User?) -> Void ) {
        print("Looking for user --------------------")
        AF.request(HOST + "user/get-by-token",
                   method: .post,
                   parameters: ["token": UserDefaults.standard.string(forKey: "token")! ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let user = self.makeUser(jsonItem: JSON(response.data!)["user"])
                    print("Found user --------------------")
                    print(user)
                    print("-------------------------------")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func updateProfile(user: User, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "user/edit-profile",
                   method: .put,
                   parameters: [
                    "_id": UserDefaults.standard.string(forKey: "id")!,
                    "firstName": user.firstName,
                    "lastName": user.lastName,
                    "cin": user.cin,
                    "email": user.email,
                    "address": user.address,
                    "password": user.password,
                    "phoneNumber": user.phoneNumber
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
    
    func editProfilePicture(email: String, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [
                        "email": email,
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: HOST + "user/edit-profile-picture",
                  method: .put)
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
    
    func makeUser(jsonItem: JSON) -> User {
        User(
            _id: jsonItem["_id"].stringValue,
            firstName: jsonItem["firstName"].stringValue,
            lastName: jsonItem["lastName"].stringValue,
            cin: jsonItem["cin"].stringValue,
            email: jsonItem["email"].stringValue,
            address: jsonItem["address"].stringValue,
            password: jsonItem["password"].stringValue,
            phoneNumber: jsonItem["phoneNumber"].stringValue,
            profilePicture: jsonItem["profilePicture"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue,
            role: jsonItem["role"].stringValue
        )
    }
}
