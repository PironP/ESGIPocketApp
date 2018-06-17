//
//  Discussion.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 15/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Discussion {
    
    
    func getDiscussions(callback: @escaping ([[String:Any]]) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/threads")!
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
