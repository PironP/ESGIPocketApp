//
//  Quiz.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 03/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Quiz {
    
    func getQuiz(callback: @escaping ([[String:Any]]) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/quizzes")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let responseData = data else {
                callback([])
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
                let dict = json as? [[String:Any]] else {
                    
                    callback([])
                    return
            }
            
            
            dict.forEach({ (section) in
                print(section)
            })
            
            callback(dict)
        }
        task.resume()
    }
}
