//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Angel Vázquez on 19/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import CoreData
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
                
                NavigationLink("Dynamically filtering FetchRequest", destination: DynamicFilteringView())
                
                 NavigationLink("Relationships in Core Data", destination: RelationshipsView())
            }
            .navigationBarTitle("Core Data")
        }
    }
}

// MARK: - First example
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

// MARK: - Second example
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

// MARK: - Third example
struct DynamicFilteringView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
        .navigationBarTitle("Dynamically filtering FetchRequest", displayMode: .inline)
    }
}

// MARK: - Generic Filtered List
struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<T>
    var list: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(list, id: \.self) { item in
            self.content(item)
        }
    }
}

// MARK: - Fourth example
struct RelationshipsView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }

            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? self.moc.save()
            }
        }
        .navigationBarTitle("One to many relationships", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
