//
//  Response.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 20/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Response {
    
    var statusCode: Int
    var error: String?
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }

    init(statusCode: Int, error: String) {
        self.statusCode = statusCode
        self.error = error
    }
}
