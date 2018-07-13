//
//  Course.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Course {
    
    var id: String
    var title: String
    var content: String
    var archive: Bool
    var like: Int
    var dislike: Int
    var topic: Topic
    var classe: Classe
    
    init(id: String, title: String, content: String, like: Int, dislike: Int, archive: Bool, topic: Topic, classe: Classe) {
        self.id = id
        self.title = title
        self.content = content
        self.like = like
        self.dislike = dislike
        self.archive = archive
        self.topic = topic
        self.classe = classe
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.title = json["title"].stringValue
        self.content = json["content"].stringValue
        self.like = json["like"].intValue
        self.dislike = json["dislike"].intValue
        self.archive = json["archive"].boolValue
        self.topic = Topic(json: json["topic"])
        self.classe = Classe(json: json["classe"])
    }
}
