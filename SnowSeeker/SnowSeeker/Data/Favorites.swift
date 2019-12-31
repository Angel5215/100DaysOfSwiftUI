//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Angel Vázquez on 29/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

class Favorites: ObservableObject {
    
    private var resorts: Set<String>
    private static let saveKey = "Favorites"
    private static let saveExtension = "json"
    
    private static var fileURL: URL {
        FileManager.documentsDirectory.appendingPathComponent(saveKey).appendingPathExtension(saveExtension)
    }
    
    init() {
        // load data
        if let data = try? Data(contentsOf: Self.fileURL),
           let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
            self.resorts = decoded
        } else {
            self.resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        return resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out data to disk
        let jsonEncoder = JSONEncoder()
        do {
            let encoded = try jsonEncoder.encode(resorts)
            try encoded.write(to: Self.fileURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("There was an error while saving: \(error.localizedDescription)")
        }
    }
}
