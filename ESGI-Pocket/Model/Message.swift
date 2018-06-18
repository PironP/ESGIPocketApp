//
//  Message.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 17/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire

class Message {
    
    func getMessages(callback: @escaping ([[String:Any]]) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/messages")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            guard let json = response.result.value else {
                callback([])
                return
            }
            
            callback(json as! [[String : Any]])
        }
    }
    
    func sendMessage(message: Dictionary<String, Any>, callback: @escaping (Bool) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/messages")!

        var  jsonData = NSData()
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted) as NSData
        } catch {
            print(error.localizedDescription)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(CurrentUser.currentUser.jwt, forHTTPHeaderField: "authorization")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            let status = (response as! HTTPURLResponse).statusCode
            
            guard let dataString = String(data: data!, encoding: String.Encoding.utf8) else {
                callback(false)
                return
            }
            
            print(dataString)
            
            if status == 404 || status == 500 {
                callback(false)
                return
            }
            
            callback(true)
            return
        }
        task.resume()
    }
}
