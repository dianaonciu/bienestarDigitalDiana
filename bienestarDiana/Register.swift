//
//  Register.swift
//  bienestarDiana
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//


import Foundation

struct RegisterResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var user: User?
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case user
    }
    
}
