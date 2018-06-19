//
//  Course.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Course {
    
    var id: String
    var title: String
    var content: String
    var archive: Bool
    var topic: Topic
    var classe: Classe
    
    init(id: String, title: String, content: String, archive: Bool, topic: Topic, classe: Classe) {
        self.id = id
        self.title = title
        self.content = content
        self.archive = archive
        self.topic = topic
        self.classe = classe
    }
}
