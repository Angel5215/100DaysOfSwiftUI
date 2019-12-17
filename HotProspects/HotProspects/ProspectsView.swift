//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Angel Vázquez on 13/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import UserNotifications
import CodeScanner
import SwiftUI

struct ProspectsView: View {
    
    // MARK: - Filtering
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortingType: CaseIterable {
        case name, mostRecent
    }
    
    // MARK: - Properties
    let filter: FilterType
   
    // MARK: - State properties
    @State private var isShowingScanner = false
    @State private var isShowingSortingActionSheet = false
    @State private var sortingMethod = SortingType.mostRecent

    // MARK: - Computed properties
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch (filter, sortingMethod) {
        case (.none, .name):
            return prospects.people.sorted { $0.name < $1.name }
        case (.none, .mostRecent):
            return prospects.people.sorted { $0.dateAdded < $1.dateAdded }
        case (.contacted, .name):
            return prospects.people.filter { $0.isContacted }.sorted { $0.name < $1.name }
        case (.contacted, .mostRecent):
            return prospects.people.filter { $0.isContacted }.sorted { $0.dateAdded < $1.dateAdded }
        case (.uncontacted, .name):
            return prospects.people.filter { !$0.isContacted }.sorted { $0.name < $1.name }
        case (.uncontacted, .mostRecent):
            return prospects.people.filter { !$0.isContacted }.sorted { $0.dateAdded < $1.dateAdded }
        }
    }
    
    // MARK: - Environment
    @EnvironmentObject var prospects: Prospects
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if self.filter == .none {
                            self.icon(for: prospect)
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                    
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: {
                self.isShowingSortingActionSheet = true
            }, label: {
                Text("Sort")
            }), trailing: Button(action: {
                self.isShowingScanner = true
            }, label: {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            }))
            .sheet(isPresented: $isShowingScanner) {
                MyCodeScannerView(codeTypes: [.qr],
                                simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                                completion: self.handleScan)
            }
            .actionSheet(isPresented: $isShowingSortingActionSheet) {
                ActionSheet(title: Text("Sort by..."), message: Text("Select an option to sort."), buttons: [
                    .default(Text("Name")) { self.sortingMethod = .name },
                    .default(Text("Most recent")) { self.sortingMethod = .mostRecent },
                    .cancel()
                ])
            }
        }
    }
    
    func icon(for prospect: Prospect) -> some View {
        if prospect.isContacted {
            return Image(systemName: "person.crop.circle.fill.badge.checkmark").foregroundColor(.green)
        } else {
            return Image(systemName: "person.crop.circle.fill.badge.exclam").foregroundColor(.secondary)
        }
    }
    
    func handleScan(result: Result<String, MyCodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
        
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none).environmentObject(Prospects())
    }
}
