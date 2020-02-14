//
//  Control.swift
//  bienestarDiana
//
//  Created by alumnos on 14/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Foundation

struct Control: Codable {
    var id: Int?
    var app, maxTime, startHour, endHour: String?

    
    init(app:String,maxTime:String,startHour:String?, endHour:String?) {
        
        self.app=app
        self.maxTime=maxTime
        self.startHour=startHour
        self.endHour = endHour
        
    }
   
    
    enum CodingKeys: String, CodingKey {
        case app, maxTime, startHour, endHour
    }
    
}
