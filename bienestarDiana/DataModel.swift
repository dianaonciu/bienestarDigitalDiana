//
//  DataModel.swift
//  bienestarDiana
//
//  Created by alumnos on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Foundation



public struct DataModel: Codable{
    
    
    
    var Date: String
    
    
    
    var App: String
    
    
    
    var Event: String
    
    
    
    var Latitude: String
    
    
    
    var Longitude: String
    
    
    
    
    
    
    
    init(Date: String, App: String, Event: String, Latitude: String, Longitude: String){
        
        
        
        self.Date = Date
        
        
        
        self.App = App
        
        
        
        self.Event = Event
        
        
        
        self.Latitude = Latitude
        
        
        
        self.Longitude = Longitude
        
        
        
    }
    
    
}
    
    
    

