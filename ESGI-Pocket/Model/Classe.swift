//
//  Classe.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 14/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Classe {
    
    
    func getSection(callback: @escaping ([[String:Any]]) -> ()) {
        
        let url = URL(string: "https://esgipocket.herokuapp.com/sections")!
        
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
