//
//  AstronautView.swift
//  Moonshot
//
//  Created by Angel Vázquez on 02/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    @State private var rotationAmount = 0.0
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
        var matches = [Mission]()
        for mission in missions where mission.crew.contains(where: { $0.name == astronaut.id }) {
            matches.append(mission)
        }
        
        self.missions = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    HStack {
                        Text("Missions")
                            .font(.title)
                            .padding(.leading)
                        Spacer()
                    }
                    
                    ForEach(self.missions) { mission in
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130)
                                .rotation3DEffect(Angle(degrees: self.rotationAmount), axis: (0, 1, 0))
                                .shadow(color: .primary, radius: 2)
                                .onAppear {
                                    withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
                                        self.rotationAmount = 360
                                    }
                                }
                            Text(mission.displayName)
                                .padding(.top)
                                .font(.headline)
                                .animation(nil)
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[10])
    }
}
