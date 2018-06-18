//
//  Quiz.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 03/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire

class Quiz {
    
    func getQuiz(callback: @escaping ([[String:Any]]) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/quizzes")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            guard let json = response.result.value else {
                callback([])
                return
            }
            
            callback(json as! [[String : Any]])
        }
    }
}
