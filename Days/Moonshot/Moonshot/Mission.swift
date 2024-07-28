//
// Mission.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String

    // MARK: - Helpers

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    // MARK: - Helper types

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}
