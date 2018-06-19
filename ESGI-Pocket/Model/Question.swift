//
//  Question.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Question {
    
    var id: String
    var content: String
    var quiz: Quiz
    
    init(id: String, content: String, quiz: Quiz) {
        self.id = id
        self.content = content
        self.quiz = quiz
    }
}