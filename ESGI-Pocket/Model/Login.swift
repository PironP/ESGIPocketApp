//
//  Login.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 09/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Login {
    
    // Async func for log the user, return in a callback the jwt or empty string if error
    func login(email: String, password: String, callback: @escaping (Bool) -> ()) {
        
        let loginUrl = URL(string: "https://esgipocket.herokuapp.com/login")!
        
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }

            if statusCode == 404 {
                callback(false)
                return
            }
            
            let json = JSON(response.result.value)
            
            if statusCode == 401 {
                if json["error"].stringValue == "Bad Credentials" {
                    callback(false)
                    return
                }
                else if (json["_id"] != nil) {
                    // go to confirm email
                    callback(false)
                    return
                }
            }
            
            CurrentUser.currentUser.jwt = json["token"].stringValue
            CurrentUser.currentUser.id = json["user"]["_id"].stringValue
            CurrentUser.currentUser.classe = Classe(json: json["user"]["classe"])
            
//            print("token = " + CurrentUser.currentUser.jwt)
//            print("id = " + CurrentUser.currentUser.id)
//            print("classe = " + CurrentUser.currentUser.classe.id)
            
            callback(true)
        }
    
    }
    
    
    func signin(email: String, password: String, firstname: String, lastName: String, callback: @escaping (String) -> ()) {
        
        let loginUrl = URL(string: "https://esgipocket.herokuapp.com//users")!
        
        let parameters: Parameters = [
            "email" :email, "password" :password, "lastname": lastName, "firstname":firstname, "status":"student"
        ]
        
        Alamofire.request(loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback("")
                return
            }
            
            if statusCode == 404 {
                callback("")
                return
            }
            
            guard let json = response.result.value,
                let jsonData = json as? [String : Any] else {
                    callback("")
                    return
            }
            
            callback(jsonData["_id"] as! String)
        }
    }
    
    func checkValidationCode(id: String, validationCode: String, callback: @escaping (Bool) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/users/activate")!
        
        let parameters: Parameters = [
            "activationCode" : Int(validationCode), "id" : CurrentUser.currentUser.id
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }
            
            if statusCode == 404 || statusCode == 500 || statusCode == 401 {
                callback(false)
                return
            }
            
            guard let json = response.result.value,
                let jsonData = json as? [String : Any] else {
                    callback(false)
                    return
            }
            
            callback(true)
        }

    }
}
