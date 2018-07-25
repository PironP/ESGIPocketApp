//
//  DiscussionProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 15/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DiscussionProvider {
    
    
    func getDiscussions(callback: @escaping ([Thread]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/threads")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var discussionList: [Thread] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value!)
                
                for (_, subJson):(String, JSON) in json {
                    discussionList.append(Thread(json: subJson))
                }
                callback(discussionList)
            }
            else {
                callback(discussionList)
            }
        }
    }
}
