//
// MissionView+CrewCarouselView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

extension MissionView {
    struct CrewCarouselView: View {
        let crew: [CrewMember]

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            CrewMemberView(crewMember: crewMember)
                        }
                    }
                }
            }
        }
    }
}
