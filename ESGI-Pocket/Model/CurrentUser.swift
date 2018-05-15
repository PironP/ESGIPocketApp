//
//  CurrentUser.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 15/05/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

final class CurrentUser {
    
    var prenom: String = ""
    var nom: String = ""
    var email: String = ""
    var jwt: String = ""
    
    private init() {}
    
    static let currentUser = CurrentUser()
    
}
