//
//  Mission.swift
//  Moonshot
//
//  Created by Angel Vázquez on 02/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    // MARK: - Nested struct
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    // MARK: - Properties
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    // MARK: - Computed properties
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
