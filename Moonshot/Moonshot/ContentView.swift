//
//  ContentView.swift
//  Moonshot
//
//  Created by Angel Vázquez on 31/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingDates = true
    var buttonTitle: String {
        showingDates ? "Show crew" : "Show date"
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(self.message(for: mission))
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(buttonTitle) {
                self.showingDates.toggle()
            })
        }
    }
    
    private func message(for mission: Mission) -> String {
        if showingDates {
            return "Launch date: \(mission.formattedLaunchDate)"
        } else {
            return mission.crew.map { $0.name.capitalized }.joined(separator: ", ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
