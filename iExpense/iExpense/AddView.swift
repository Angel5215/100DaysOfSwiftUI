//
//  AddView.swift
//  iExpense
//
//  Created by Angel Vázquez on 29/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save", action: saveItem))
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func saveItem() {
        guard let actualAmount = Int(self.amount) else {
            showingAlert = true
            alertTitle = "Error"
            alertMessage = "Please type an integer number."
            return
        }
        
        guard actualAmount > 0 else {
            showingAlert = true
            alertTitle = "Wrong amount"
            alertMessage = "Amount should be a positive number"
            return
        }
        
        let item = ExpenseItem(name: name, type: type, amount: actualAmount)
        expenses.items.append(item)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
