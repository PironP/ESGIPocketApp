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
    
    var cours: String = ""
    var date: String = ""
    var heureDebut: String = ""
    var heureFin: String = ""
    var salle: String = ""
    
    init(cours: String, date: String, heureDebut: String, heureFin: String, salle: String) {
        self.cours = cours
        self.date = date
        self.heureDebut = heureDebut
        self.heureFin = heureFin
        self.salle = salle
    }
    
    init(json: JSON) {
        self.cours = json["cours"].stringValue
        self.date = json["date"].stringValue
        self.heureDebut = json["heureDebut"].stringValue
        self.heureFin = json["heureFin"].stringValue
        self.salle = json["salle"].stringValue
    }
    
}
