//
//  CurrentUser.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 15/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

final class CurrentUser {
    
    var id: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""
    var jwt: String = ""
    var classe: Classe!
    
    private init() {}
    
    static let currentUser = CurrentUser()
    
}
