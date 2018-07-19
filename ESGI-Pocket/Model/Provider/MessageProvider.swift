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
        
        let url = URL(string: ServerAdress.serverAdress + "/threads/" + threadId + "/messages")!

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
        
        let url = URL(string: ServerAdress.serverAdress + "/messages")!
        
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
    
    func getAllPrivateMessages(callback: @escaping ([Message]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/messages/" + CurrentUser.currentUser.id + "/messages")!
        
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
    
    func getPrivateMessages(idReceiver: String, callback: @escaping ([Message]) -> ()) {
        
        // TODO
        let url = URL(string: ServerAdress.serverAdress + "/messages/" + idReceiver + "/messages")!
        
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
    
    func sendPrivateMessage(message: String, idReceiver: String, callback: @escaping (Bool) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/messages")!
        
        // TO TEST
        let parameters: Parameters = [
            "message": message,
            "receiver": idReceiver
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
    
    func deleteMessage(messageId: String, callback: @escaping (Bool) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/messages/" + messageId)!
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, method: .delete,encoding: JSONEncoding.default , headers: headers).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }
            
            if statusCode == 404 || statusCode == 500 {
                callback(false)
                return
            }
            
            callback(true)
        }
    }
}
