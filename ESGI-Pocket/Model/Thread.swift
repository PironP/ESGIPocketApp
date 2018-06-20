//
//  Thread.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 20/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Thread {
    
    var id: String
    var name: String
    var restricted: Bool
    var speciality: String
    var classe: Classe
    
    init(id: String, name: String, restricted: Bool, speciality: String, classe: Classe) {
        self.id = id
        self.name = name
        self.restricted = restricted
        self.speciality = speciality
        self.classe = classe
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.restricted = json["restricted"].boolValue
        self.speciality = json["speciality"].stringValue
        self.classe = Classe(json: json["classe"])
    }
}
