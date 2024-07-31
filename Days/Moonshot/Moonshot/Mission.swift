//
// Mission.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    // MARK: - Helpers

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    func formattedLaunchDate(style: Date.FormatStyle.DateStyle = .abbreviated, defaultValue: String = "N/A") -> String {
        launchDate?.formatted(date: style, time: .omitted) ?? defaultValue
    }

    // MARK: - Helper types

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}
