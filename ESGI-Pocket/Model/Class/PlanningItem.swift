//
//  PlanningItem.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 20/07/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class PlanningItem {
    
    var topic: String = ""
    var date: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var room: String = ""
    
    init(topic: String, date: String, startTime: String, endTime: String, room: String) {
        self.topic = topic
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.room = room
    }
    
    init(json: JSON, date: String) {
        self.topic = json["subject"].stringValue
        self.date = date
        self.startTime = json["beginning"].stringValue
        self.endTime = json["end"].stringValue
        self.room = json["classrooms"][0].stringValue
    }
    
}
