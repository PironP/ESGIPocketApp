//
//  Answer.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 21/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Answer {
    
    var id: String = ""
    var content: String = ""
    var isRightAnswer: Bool = false
    
    init(id: String, isRightAnswer: Bool) {
        self.id = id
        self.isRightAnswer = isRightAnswer
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.content = json["content"].stringValue
        self.isRightAnswer = json["rightAnswer"].boolValue
    }
}
