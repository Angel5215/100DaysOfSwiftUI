//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Angel Vázquez on 27/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    
    @State private var selectedUser: User? = nil
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                self.selectedUser = User()
            }
        .alert(item: $selectedUser) { user in
            Alert(title: Text(user.id))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
