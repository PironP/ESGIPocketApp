//
//  Topic.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Topic {
    
    var id: String
    var name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
    }
}
