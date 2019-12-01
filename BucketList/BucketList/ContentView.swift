//
//  ContentView.swift
//  BucketList
//
//  Created by Angel Vázquez on 30/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

extension FileManager {
    var documentsDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct ContentView: View {

    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
