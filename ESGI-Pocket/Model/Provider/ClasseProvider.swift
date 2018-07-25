//
//  ClasseProvider.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 14/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ClasseProvider {
    
    func getClasses(callback: @escaping ([Classe]) -> ()) {
        
        let url = URL(string: ServerAdress.serverAdress + "/classes")!

        let headers: HTTPHeaders = ["authorization": CurrentUser.currentUser.jwt]
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            
            var classeList: [Classe] = []
            
            if response.result.isSuccess {
                
                let json = JSON(response.result.value!)
                
                for (_, subJson):(String, JSON) in json {
                    classeList.append(Classe(json: subJson))
                }
                
                callback(classeList)
            }
            else {
                callback(classeList)
            }
        }
    }
}
