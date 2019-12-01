//
//  ContentView.swift
//  BucketList
//
//  Created by Angel Vázquez on 30/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import LocalAuthentication
import SwiftUI

extension FileManager {
    var documentsDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct ContentView: View {

    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if self.isUnlocked {
                ZStack {
                    MapView().edgesIgnoringSafeArea(.all)
                    Text("Unlocked")
                }
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // There was a problem
                    }
                }
            }
        } else {
            // No biometrics
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
