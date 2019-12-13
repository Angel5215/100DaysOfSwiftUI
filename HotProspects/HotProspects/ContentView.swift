//
//  ContentView.swift
//  HotProspects
//
//  Created by Angel Vázquez on 10/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SamplePackage
import SwiftUI
import UserNotifications

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

class DelayedUpdater: ObservableObject {
    
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

// MARK: - Views
struct ContentView: View {
    
    @ObservedObject var updater = DelayedUpdater()
    @State private var backgroundColor = Color.red
    
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Group {
                Text("Local notifications")
                    .font(.title)
                    .fontWeight(.bold)
                Button("Request permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                Button("Schedule notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default
                    
                    // triggers 5 seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                }
            }
            
            Spacer()
            
            Group {
                Text("Context menus")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Hello, World!")
                    .padding()
                    .background(backgroundColor)
                
                Text("Change Color")
                    .padding()
                    .contextMenu {
                        Button(action: {
                            self.backgroundColor = .red
                        }) {
                            Text("Red")
                            Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.red)
                        }
                        
                        Button(action: {
                            self.backgroundColor = .green
                        }) {
                            Text("Green")
                        }
                        
                        Button(action: {
                            self.backgroundColor = .blue
                        }) {
                            Text("Blue")
                        }
                }
            }
            
            Spacer()
          
            Group {
                Text("Swift Package dependencies")
                .font(.title)
                .fontWeight(.bold)
                
                Text(results)
            }
            
            Spacer()

        }
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}


// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
