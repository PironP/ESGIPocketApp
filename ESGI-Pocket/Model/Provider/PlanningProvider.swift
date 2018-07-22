//
//  PlanningProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 20/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PlanningProvider {
    
    func getClassPlanning(idClass: String, callback: @escaping ([Planning]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/plannings/" + idClass + "/classe")!
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var planningList: [Planning] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                planningList = self.sortPlanningsByMostRecent(planningList: planningList)
                
                for (_, subJson):(String, JSON) in json {
                    if (subJson["class"].stringValue == idClass) {
                        planningList.append(Planning(json: subJson))
                    }
                }
                callback(planningList)
            }
            else {
                callback(planningList)
            }
        }
    }
    
    func sortPlanningsByMostRecent(planningList: [Planning]) -> [Planning] {
        var planningsToSort = planningList
        planningsToSort.sort { (planning1, planning2) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            dateFormatter.locale = Locale(identifier: "fr_FR")
            
            guard let formattedDatePlanning1 = dateFormatter.date(from: planning1.uploadedAt) else {
                return false
            }
            guard let formattedDatePlanning2 = dateFormatter.date(from: planning2.uploadedAt) else {
                return true
            }
            return formattedDatePlanning1 >= formattedDatePlanning2
                
        }
        
        return planningsToSort
    }
}
