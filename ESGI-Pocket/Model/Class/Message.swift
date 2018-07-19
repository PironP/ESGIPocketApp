//
//  Message.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Message {
    
    var id: String
    var message: String
    var createdAt: String
    var user: User
    var receiverId: String?
    var thread: Thread?
    
    init(id: String, message: String, createdAt: String, user: User, thread: Thread) {
        self.id = id
        self.message = message
        self.createdAt = createdAt
        self.user = user
        self.thread = thread
    }
    
    init(id: String, message: String, createdAt: String, user: User, receiverId: String) {
        self.id = id
        self.message = message
        self.createdAt = createdAt
        self.user = user
        self.receiverId = receiverId
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.message = json["message"].stringValue
        self.createdAt = json["createdAt"].stringValue
        self.user = User(json: json["user"])
        if json["receiver"].exists() {
            self.receiverId = json["receiver"].stringValue
        } else {
        self.thread = Thread(json: json["thread"])
        }
    }
}
