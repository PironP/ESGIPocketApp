//
//  Quiz.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Quiz {
    
    var id: String
    var name: String
    var topic: Topic
    var author: User
    var questions: [Question] = []
    
    init(id: String, name: String, topic: Topic, author: User) {
        self.id = id
        self.name = name
        self.topic = topic
        self.author = author
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.topic = Topic(json: json["topic"])
        self.author = User(json: json["user"])
    }
}
