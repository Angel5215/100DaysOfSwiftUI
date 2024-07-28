//
// MissionView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.6
                    }
                    .padding(.top)

                VStack(alignment: .leading) {
                    CustomDivider()

                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)

                    CustomDivider()

                    Text("Crew")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .padding(.bottom)
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                Text("Astronaut details")
                            } label: {
                                CrewMemberView(crewMember: crewMember)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

extension MissionView {
    struct CustomDivider: View {
        var body: some View {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.lightBackground)
                .padding(.vertical)
        }
    }
}

extension MissionView {
    struct CrewMemberView: View {
        let crewMember: CrewMember

        var body: some View {
            ZStack(alignment: .bottom) {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 273, height: 200)

                LinearGradient(
                    colors: [
                        .lightBackground.opacity(0),
                        .darkBackground,
                    ],
                    startPoint: .center,
                    endPoint: .bottom
                )

                VStack {
                    Text(crewMember.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                    Text(crewMember.role)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(.regularMaterial.opacity(0.4))
            }
            .clipShape(
                .rect(
                    cornerRadii: RectangleCornerRadii(
                        topLeading: 24,
                        bottomTrailing: 24
                    ),
                    style: .continuous
                )
            )
            .overlay(
                UnevenRoundedRectangle(
                    cornerRadii: RectangleCornerRadii(
                        topLeading: 24,
                        bottomTrailing: 24
                    ),
                    style: .continuous
                )
                .strokeBorder(.lightBackground, lineWidth: 2)
            )
            .padding(.horizontal)
            .dynamicTypeSize(.xSmall ... .xxxLarge)

//            HStack {
//                Image(crewMember.astronaut.id)
//                    .resizable()
//                    .frame(width: 104, height: 72)
//                    .clipShape(.capsule)
//                    .overlay(
//                        Capsule()
//                            .strokeBorder(.white, lineWidth: 1)
//                    )
//
//                VStack(alignment: .leading) {
//                    Text(crewMember.astronaut.name)
//                        .foregroundStyle(.white)
//                        .font(.headline)
//                    Text(crewMember.role)
//                        .foregroundStyle(.white.opacity(0.5))
//                }
//            }
//            .padding(.horizontal)
        }
    }
}

extension MissionView {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return NavigationStack {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
