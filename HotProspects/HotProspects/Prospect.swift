//
//  Prospect.swift
//  HotProspects
//
//  Created by Angel Vázquez on 13/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

fileprivate extension FileManager {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    var dateAdded = Date()
}

class Prospects: ObservableObject {
    
    static let saveKey = "SavedData"
    
    @Published private(set) var people: [Prospect]
    
    init() {
        let documentsDirectory = FileManager.documentsDirectory
        let fileURL = documentsDirectory.appendingPathComponent(Self.saveKey)
        if let data = try? Data(contentsOf: fileURL) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        let documentsDirectory = FileManager.documentsDirectory
        let fileURL = documentsDirectory.appendingPathComponent(Self.saveKey)
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        if let encoded = try? jsonEncoder.encode(people) {
            do {
                try encoded.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
