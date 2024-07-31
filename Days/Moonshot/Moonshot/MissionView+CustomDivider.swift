//
// MissionView+CustomDivider.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

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
