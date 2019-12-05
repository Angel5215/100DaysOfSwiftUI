//
//  ContentView.swift
//  BucketList
//
//  Created by Angel Vázquez on 30/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    @State private var showingAuthenticationError = false
    @State private var authenticationErrorMessage = ""
    
    
    var body: some View {
        Group {
            if isUnlocked {
                UnlockedView(centerCoordinate: $centerCoordinate,
                             selectedPlace: $selectedPlace,
                             showingPlaceDetails: $showingPlaceDetails,
                             locations: $locations,
                             showingEditScreen: $showingEditScreen)
                .alert(isPresented: $showingPlaceDetails) {
                    Alert(title: Text(selectedPlace?.title ?? "Unknown"),
                          message: Text(selectedPlace?.subtitle ?? "Missing place information."),
                          primaryButton: .default(Text("OK")),
                          secondaryButton: .default(Text("Edit")) {
                        self.showingEditScreen = true
                    })
                }
            } else {
                LockedView(action: authenticate)
                .alert(isPresented: $showingAuthenticationError) {
                    Alert(title: Text("Authentication error"),
                          message: Text("Error: \(authenticationErrorMessage)"),
                          dismissButton: .default(Text("OK")))
                }
            }
        }
        
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showingAuthenticationError = true
                        self.authenticationErrorMessage = authenticationError?.localizedDescription ?? "Unknown error"
                    }
                }
            }
        } else {
            self.showingAuthenticationError = true
            self.authenticationErrorMessage = "No biometrics available"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
