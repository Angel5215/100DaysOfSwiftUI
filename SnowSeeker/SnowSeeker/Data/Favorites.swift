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
    private let saveKey = "Favorites"
    
    init() {
        // load data
        
        // default to an empty array
        self.resorts = []
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
        
    }
}
