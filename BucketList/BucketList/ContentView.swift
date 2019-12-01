//
//  ContentView.swift
//  BucketList
//
//  Created by Angel Vázquez on 30/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

extension FileManager {
    var documentsDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test message"
                
                // PATH-TO-DOCUMENTS/message.txt
                let url = FileManager.default.documentsDirectory.appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
