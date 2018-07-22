//
//  Question.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Question {
    
    var id: String
    var content: String
    var quiz: Quiz
    var answers: [Answer] = []
    
    init(id: String, content: String, quiz: Quiz) {
        self.id = id
        self.content = content
        self.quiz = quiz
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.content = json["content"].stringValue
        self.quiz = Quiz(json: json["quiz"])
        setQuestion(json: json["answers"])
    }
    
    func setQuestion(json: JSON) {
        for (_, answer):(String, JSON) in json {
            self.answers.append(Answer(json: answer))
        }
    }
}
