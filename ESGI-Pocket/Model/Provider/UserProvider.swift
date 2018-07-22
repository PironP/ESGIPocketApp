//
//  UserProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserProvider {
    
    func getUsers(callback: @escaping ([User]) -> ()) {
        
        let url: URL
        
            url = URL(string: ServerAdress.serverAdress + "/users")!

        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var userList: [User] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (_, subJson):(String, JSON) in json {
                    userList.append(User(json: subJson))
                }
                callback(userList)
            }
            else {
                callback(userList)
            }
        }
    }
    
    func selectClassForUser(idClass: String, idUser: String, callback: @escaping (Bool) -> ()) {

        let url = URL(string: ServerAdress.serverAdress + "/users/" + idUser)!
        
        let parameters: Parameters = [
            "class" :idClass, "id": idUser]
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }
            
            if statusCode == 404 || statusCode == 500 {
                callback(false)
                return
            }
            
            let json = JSON(response.value)
            
            CurrentUser.currentUser.classe = Classe(json: json)
            
            
            
            callback(true)
        }
    }
    
}
