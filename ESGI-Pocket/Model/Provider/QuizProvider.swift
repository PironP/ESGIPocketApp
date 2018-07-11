//
//  QuizProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 03/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class QuizProvider {
    
    func getQuizzes(callback: @escaping ([Quiz]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/quizzes")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var quizList: [Quiz] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (index,subJson):(String, JSON) in json {
                    quizList.append(Quiz(json: subJson))
                }
                callback(quizList)
            }
            else {
                callback(quizList)
            }
        }
    }
    
    func getQuiz(quizId: String, callback: @escaping (Quiz) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/quizzes/" + quizId)!
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            if response.result.isSuccess {
                let json = JSON(response.result.value)
                
                callback(Quiz(json: json))
            }
        }
    }
}
