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
    
    func getTopicCourses(idTopic: String, callback: @escaping ([Course]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/topics/" + idTopic + "/courses")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var coursesList: [Course] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value)
                
                for (index,subJson):(String, JSON) in json {
                    coursesList.append(Course(json: subJson))
                }
                
                
                callback(coursesList)
            }
            else {
                callback(coursesList)
            }
        }
    }
    
    func getVoteForCourse(idCourse: String, callback: @escaping (JSON) -> ()) {
        
        // TO CHANGE
        let url = URL(string: ServerAdress.serverAdress + "/topics/" + idCourse + "/courses")!
        
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
    
    func addVoteForCourse(idCourse: String, like: Bool, callback: @escaping (Bool) -> ()) {
        
        // TO CHANGE
        let url = URL(string: ServerAdress.serverAdress + "/topics/" + idCourse + "/courses")!
        
        let parameters: Parameters = [
        "idCourse" :idCourse, "like": like.description]
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }
            
            if statusCode == 404 {
                callback(false)
                return
            }
            
            guard let json = response.result.value,
                let jsonData = json as? [String : Any] else {
                    callback(false)
                    return
            }
            
            callback(true)
        }
    }
    
    func changeVoteForCourse(idCourse: String, like: Bool, callback: @escaping (Bool) -> ()) {
        // TO CHANGE
        let url = URL(string: ServerAdress.serverAdress + "/topics/" + idCourse + "/courses")!
        
        let parameters: Parameters = [
            "idCourse" :idCourse]
        
        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                callback(false)
                return
            }
            
            if statusCode == 404 {
                callback(false)
                return
            }
            
            guard let json = response.result.value,
                let jsonData = json as? [String : Any] else {
                    callback(false)
                    return
            }
            
            callback(true)
        }
    }
}
