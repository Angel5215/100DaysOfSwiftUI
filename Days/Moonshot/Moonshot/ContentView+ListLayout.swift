//
// ContentView+ListLayout.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

extension ContentView {
    struct ListLayout: View {
        let missions: [Mission]

        var body: some View {
            List {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipped()
                                .padding(.vertical)

                            VStack(alignment: .leading, spacing: 8) {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate())
                                    .font(.body)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding()
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
        }
    }
}
