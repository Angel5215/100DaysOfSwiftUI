//
//  LockedView.swift
//  BucketList
//
//  Created by Angel Vázquez on 04/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct LockedView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button("Unlock Places") {
            self.action()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct LockedView_Previews: PreviewProvider {
    static var previews: some View {
        LockedView() { }
    }
}
