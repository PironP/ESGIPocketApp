//
//  Course.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 17/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Course {
    
    func getCourses(callback: @escaping ([[String:Any]]) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/courses")!
        var request = URLRequest(url: url)
        request.setValue(CurrentUser.currentUser.jwt, forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let responseData = data, let dataString = String(data: responseData, encoding: String.Encoding.utf8) else {
                callback([])
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
                let dict = json as? [[String: Any]] else{
                    callback([])
                    return
            }
            
            callback(dict)
        }
        task.resume()
    }
    
}
