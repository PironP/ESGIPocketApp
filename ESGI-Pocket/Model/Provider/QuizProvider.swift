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
                
                for (_,subJson):(String, JSON) in json {
                    quizList.append(Quiz(json: subJson))
                }
                callback(quizList)
            }
            else {
                callback(quizList)
            }
        }
    }
    
    func getQuestions(quiz: Quiz, callback: @escaping ([Question]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/quizzes/" + quiz.id + "/questions")!
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var questionList: [Question] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (_, subJson):(String, JSON) in json {
                    questionList.append(Question(json: subJson))
                }
                
                callback(questionList)
            }
            else {
                callback(questionList)
            }
        }
    }
    
    func getQuestions(callback: @escaping ([Question]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/questions")!
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var questionList: [Question] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (_,subJson):(String, JSON) in json {
                    questionList.append(Question(json: subJson))
                }
                
                callback(questionList)
            }
            else {
                callback(questionList)
            }
        }
    }
    
    func getAnswers(question: Question, callback: @escaping ([Answer]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/questions/" + question.id + "/answers")!
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var answserList: [Answer] = []
            
            if response.result.isSuccess {
                let json = JSON(response.result.value)
                
                for (_, subJson):(String, JSON) in json {
                    answserList.append(Answer(json: subJson))
                }
                
                callback(answserList)
            }
            else {
                callback(answserList)
            }
        }
    }
    
    func uploadQuizResult(result: Int, idUser: String, idQuiz: String, callback: @escaping (Bool) -> ()) {
        
        
        let url = URL(string: ServerAdress.serverAdress + "/quizzesStudent")!
        
        
        let parameters: Parameters = [
            "resultat" :result, "user" :idUser, "quiz": idQuiz
        ]
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }
            
            if statusCode == 404 || statusCode == 500 {
                callback(false)
                return
            }
            
            callback(true)
        }
    }


}
