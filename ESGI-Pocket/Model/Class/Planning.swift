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
    var items: [PlanningItem] = []
    
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
        if (json["content"].exists()) {
            setPlanningItems(json: json["content"])
            
        }
    }
    
    func setPlanningItems(json: JSON) {
        for (_, weeks):(String, JSON) in json["weeks"] {
            for (_, days):(String, JSON) in weeks["days"] {
                for (_, courses):(String, JSON) in days["courses"] {
                    self.items.append(PlanningItem(json: courses, date: days["date"].stringValue))
                }
            }
        }
        filterOverdueClasses()
    }
    
    func filterOverdueClasses() {
        self.items = self.items.filter({ (item) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "fr_FR")

            
            guard let formattedDate = dateFormatter.date(from: item.date) else {
                return false
            }
            return formattedDate >= Date()
        })
    }
}
