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
    
    func getUser(username: String, callback: @escaping ([User]) -> ()) {
        
        let url: URL
        
        if username == "" {
            url = URL(string: "https://esgipocket.herokuapp.com/users")!
        } else {
            url = URL(string: "https://esgipocket.herokuapp.com/users/" + username)!
        }

        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var userList: [User] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (index,subJson):(String, JSON) in json {
                    userList.append(User(json: subJson))
                }
                callback(userList)
            }
            else {
                callback(userList)
            }
        }
    }
    
}
