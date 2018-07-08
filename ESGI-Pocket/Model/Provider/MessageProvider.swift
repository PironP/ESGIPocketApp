//
//  MessageProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 17/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageProvider {
    
    func getThreadMessages(threadId: String, callback: @escaping ([Message]) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/threads/" + threadId + "/messages")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
            
            var messageList: [Message] = []
            
            if response.result.isSuccess {
            
                let json = JSON(response.result.value)
                
                for (index,subJson):(String, JSON) in json {
                    messageList.append(Message(json: subJson))
                }
                callback(messageList)
            }
            else {
                callback(messageList)
            }
        }
    }
    
    func sendThreadMessage(message: String, idDiscussion: String, callback: @escaping (Bool) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/messages")!
        
        let parameters: Parameters = [
            "message": message,
            "thread": idDiscussion
        ]
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }
            
            if statusCode == 404 || statusCode == 401 {
                callback(false)
                return
            }

            callback(true)
        }
    }
}
