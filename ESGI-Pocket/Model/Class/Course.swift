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
    var content: String?
    var url: String?
    var archive: Bool
    var like: Int
    var dislike: Int
    var topic: Topic
    var classe: Classe
    var authorName: String
    
    init(id: String, title: String, like: Int, dislike: Int, archive: Bool, topic: Topic, classe: Classe, authorName: String) {
        self.id = id
        self.title = title
        self.like = like
        self.dislike = dislike
        self.archive = archive
        self.topic = topic
        self.classe = classe
        self.authorName = authorName
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.title = json["title"].stringValue
        self.like = json["like"].intValue
        self.dislike = json["dislike"].intValue
        self.archive = json["archive"].boolValue
        self.topic = Topic(json: json["topic"])
        self.classe = Classe(json: json["classe"])
        self.authorName = json["user"]["firstname"].stringValue + " " + json["user"]["lastname"].stringValue
        
        if json["content"].exists() {
            self.content = json["content"].stringValue
        } else if json["url"].exists() {
            self.url = json["url"].stringValue
        }
    }
}
