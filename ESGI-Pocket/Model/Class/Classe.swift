//
//  Classe.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class Classe {
    
    var id: String
    var year: String
    var group: String
    var speciality: String
    var specialityAcronym: String
    var topics: [Topic]?
    
    init(id: String, year: String, group: String, speciality: String, specialityAcronym: String) {
        self.id = id
        self.year = year
        self.group = group
        self.speciality = speciality
        self.specialityAcronym = specialityAcronym
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.year = json["year"]["name"].stringValue
        self.group = json["group"]["name"].stringValue
        self.speciality = json["speciality"]["name"].stringValue
        self.specialityAcronym = json["speciality"]["acronym"].stringValue
    }

}
