//
//  AnimationStackView.swift
//  Animations
//
//  Created by Angel Vázquez on 26/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct AnimationStackView: View {
    
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(nil)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct AnimationStackView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationStackView()
    }
}
