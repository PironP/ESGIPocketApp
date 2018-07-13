//
//  TopicProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 17/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TopicProvider {
    
    func getAllTopics(callback: @escaping ([Topic]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/topics")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var topicList: [Topic] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (index,subJson):(String, JSON) in json {
                    topicList.append(Topic(json: subJson))
                }
                callback(topicList)
            }
            else {
                callback(topicList)
            }
        }
    }
    
}
