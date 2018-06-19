//
//  Quiz.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Quiz {
    
    var id: String
    var name: String
    var topic: Topic
    
    init(id: String, name: String, topic: Topic) {
        self.id = id
        self.name = name
        self.topic = topic
    }
}
