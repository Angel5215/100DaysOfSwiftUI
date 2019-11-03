//
//  Mission.swift
//  Moonshot
//
//  Created by Angel Vázquez on 02/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
