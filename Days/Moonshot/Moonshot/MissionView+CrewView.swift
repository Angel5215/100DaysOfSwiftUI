//
// MissionView+CrewView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

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
