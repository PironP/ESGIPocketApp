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
        
        let url = URL(string: ServerAdress.serverAdress + "/plannings")!
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var planningList: [Planning] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (index,subJson):(String, JSON) in json {
                    if (subJson["classe"]["_id"].stringValue == idClass) {
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
}
