//
//  loginController.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 09/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Login {
    
    // Async func for log the user, return in a callback the jwt or empty string if error
    static func login(username: String, password: String, callback: @escaping (String) -> ()) {
        
        let loginUrl = URL(string: "https://esgipocket.herokuapp.com/auth/login")!
        
        var dict = Dictionary<String, Any>()
        dict = ["email" :username, "password" :password]
        var  jsonData = NSData()
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) as NSData
        } catch {
            print(error.localizedDescription)
        }
        
        var request = URLRequest(url: loginUrl)
        request.httpMethod = "POST"
        request.setValue("\(jsonData.length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            let status = (response as! HTTPURLResponse).statusCode
            
            if status == 404 {
                callback("")
                return
            }
            guard let responseData = data, let dataString = String(data: responseData, encoding: String.Encoding.utf8) else {
                callback("")
                return
            }
            
            callback(dataString)
        }
        task.resume()
    }
    
}
