//
//  QuestionProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 17/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class QuestionProvider {

    func getQuestions(callback: @escaping (JSON) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/questions")!

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
