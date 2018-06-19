//
//  Classe.swift
//  ESGI-Pocket
//
//  Created by pierre piron on 19/06/2018.
//  Copyright © 2018 pierre piron. All rights reserved.
//

import Foundation

class Classe {
    
    var id: String
    var year: String
    var group: String
    var speciality: String
    
    init(id: String, year: String, group: String, speciality: String) {
        self.id = id
        self.year = year
        self.group = group
        self.speciality = speciality
    }
}
