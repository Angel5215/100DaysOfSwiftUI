//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Angel Vázquez on 22/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectionToggle: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Card options")) {
                    Toggle(isOn: $selectionToggle) {
                        Text("Wrong cards go back to selection")
                    }
                }
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing: Button("Done", action: dismiss))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        saveData()
        presentationMode.wrappedValue.dismiss()
    }
    
    func saveData() {
        UserDefaults.standard.set(selectionToggle, forKey: "SelectionSetting")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectionToggle: .constant(false))
    }
}
