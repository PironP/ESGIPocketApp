//
//  User.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var id: String
    var firstname: String
    var lastname: String
    var email: String
    var role: Int
    var classe: Classe
    
    init(id: String, firstname: String, lastname: String, email: String, role: Int, classe: Classe ) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.role = role
        self.classe = classe
    }
    
    init(json: JSON) {
        self.id = json["_id"].stringValue
        self.firstname = json["firstname"].stringValue
        self.lastname = json["lastname"].stringValue
        self.email = json["email"].stringValue
        self.role = json["role"].intValue
        self.classe = Classe(json: json["classe"])
    }
}
