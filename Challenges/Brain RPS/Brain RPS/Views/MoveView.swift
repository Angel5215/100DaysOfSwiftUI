//
//  MoveView.swift
//  Brain RPS
//
//  Created by Angel Vázquez on 17/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

// MARK: - MoveView
struct MoveView: View {
    let type: Move
    let fontSize: CGFloat
    
    init(type: Move, fontSize: CGFloat = 140) {
        self.type = type
        self.fontSize = fontSize
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(type.emoji)
                .font(.system(size: fontSize))
                .padding()
            Text(type.rawValue.uppercased())
        }
    }
}

// MARK: - MoveView preview
struct MoveView_Previews: PreviewProvider {
    static var previews: some View {
        let moves = Move.allCases.shuffled()
        let randomMove = moves[Int.random(in: 0...2)]
        return MoveView(type: randomMove)
    }
}
