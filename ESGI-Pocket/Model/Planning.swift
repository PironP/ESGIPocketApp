//
//  Planning.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 20/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Planning {
    
    var id: String
    var content: JSON
    var uploadedAt: String
    var classe: Classe
    
    init(id: String, content: JSON, uploadedAt: String, classe: Classe) {
        self.id = id
        self.content = content
        self.uploadedAt = uploadedAt
        self.classe = classe
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.content = json["content"]
        self.uploadedAt = json["uploadedAt"].stringValue
        self.classe = Classe(json: json["classe"])
    }
}