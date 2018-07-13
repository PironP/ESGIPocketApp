//
//  CurrentUser.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 15/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation
import SwiftyJSON

final class CurrentUser {
    
    var id: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""
    var role: Int = 2
    var jwt: String = ""
    var classe: Classe?
    
    private init() {}
    
    static let currentUser = CurrentUser()
    
    public func setValue(json: JSON) {
        self.jwt = json["token"].stringValue
        self.id = json["user"]["_id"].stringValue
        self.email = json["user"]["email"].stringValue
        self.firstname = json["user"]["firstname"].stringValue
        self.lastname = json["user"]["lastname"].stringValue
        self.role = json["user"]["role"].intValue
        
        if json["user"]["class"].exists() {
            self.classe = Classe(json: json["user"]["class"])
        }
    }
    
}
