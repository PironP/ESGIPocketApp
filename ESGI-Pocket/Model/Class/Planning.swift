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
        for (_, subJson1):(String, JSON) in json {
            for (_, subJson2):(String, JSON) in subJson1 {
                for (_, subJson3):(String, JSON) in subJson2 {
                    for (_, subJson4):(String, JSON) in subJson3 {
                        for (_, subJson5):(String, JSON) in subJson4 {
                            for (_, subJson6):(String, JSON) in subJson5 {
                                self.items.append(PlanningItem(json: subJson6, date: subJson4["date"].stringValue))
                            }
                        }
                    }
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
