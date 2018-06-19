//
//  CourseProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 17/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CourseProvider {
    
    func getTopicCourses(idTopic: String, callback: @escaping (JSON) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/topics/" + idTopic + "/courses")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                callback(json)
            }
            else {
                callback(JSON())
            }
        }
    }
}
