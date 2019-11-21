//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Angel Vázquez on 19/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Core Data constraints", destination: UniqueConstraintsView())
                
                NavigationLink("Filtering with NSPredicate", destination: FilteringView())
            }
            .navigationBarTitle("Core Data")
        }
    }
}

struct FilteringView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
        .navigationBarTitle("Filtering with NSPredicate", displayMode: .inline)
    }
}

struct UniqueConstraintsView: View {
    let students = [
        Student(name: "Harry Potter"),
        Student(name: "Hermione Granger")
    ]
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .navigationBarTitle("Core Data constraints", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
