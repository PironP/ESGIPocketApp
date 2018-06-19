//
//  Message.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Message {
    
    var id: String
    var message: String
    var user: User
    var receiver: User?
    var thread: Thread?
    
    init(id: String, message: String, user: User, thread: Thread) {
        self.id = id
        self.message = message
        self.user = user
        self.thread = thread
    }
    
    init(id: String, message: String, user: User, receiver: User) {
        self.id = id
        self.message = message
        self.user = user
        self.receiver = receiver
    }
}
