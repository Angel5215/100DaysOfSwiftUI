//
// Astronaut.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

struct Astronaut: Hashable, Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

struct CrewMember: Hashable, Codable {
    let role: String
    let astronaut: Astronaut
}
