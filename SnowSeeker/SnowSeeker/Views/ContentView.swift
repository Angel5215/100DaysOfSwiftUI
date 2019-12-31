//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Angel Vázquez on 27/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @ObservedObject var favorites = Favorites()
    
    enum SortMethod: String {
        case alphabetical = "Alphabetical"
        case country = "Country"
        case defaultSort = "No sort"
    }
    
    enum FilterMethod: String {
        case countryLessM = "A - M"
        case countryMoreM = "M - Z"
        case sizeOne = "Small"
        case sizeTwo = "Medium"
        case sizeThree = "Big"
        case priceOne = "$"
        case priceTwo = "$$"
        case priceThree = "$$$"
        case none = "No filter"
    }
    
    @State private var showingSortSheet = false
    @State private var showingFilterSheet = false
    @State private var sortMethod = SortMethod.defaultSort
    @State private var filterMethod = FilterMethod.none
    
    var transformedResorts: [Resort] {
        let filteredResorts: [Resort]
        switch filterMethod {
        case .countryLessM:
            filteredResorts = resorts.filter { $0.country <= "M" }
        case .countryMoreM:
            filteredResorts = resorts.filter { $0.country >= "M" }
        case .sizeOne:
            filteredResorts = resorts.filter { $0.size == 1 }
        case .sizeTwo:
            filteredResorts = resorts.filter { $0.size == 2 }
        case .sizeThree:
            filteredResorts = resorts.filter { $0.size == 3 }
        case .priceOne:
            filteredResorts = resorts.filter { $0.price == 1 }
        case .priceTwo:
            filteredResorts = resorts.filter { $0.price == 2 }
        case .priceThree:
            filteredResorts = resorts.filter { $0.price == 3 }
        default:
            filteredResorts = resorts
        }
        
        switch sortMethod {
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        default:
            return filteredResorts
        }
    }
    
    var sortButton: some View {
        Button("Sort") {
            self.showingSortSheet = true
        }
        .actionSheet(isPresented: $showingSortSheet) {
            ActionSheet(title: Text("Sort by..."), message: nil, buttons: [
                .default(Text(SortMethod.alphabetical.rawValue)) { self.sortMethod = .alphabetical },
                .default(Text(SortMethod.country.rawValue)) { self.sortMethod = .country },
                .default(Text(SortMethod.defaultSort.rawValue)) { self.sortMethod = .defaultSort },
                .cancel()
            ])
        }
    }
    
    var filterButton: some View {
        Button("Filter") {
            self.showingFilterSheet = true
        }
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Filter by..."), message: nil, buttons: [
                .default(Text(FilterMethod.countryLessM.rawValue)) { self.filterMethod = .countryLessM },
                .default(Text(FilterMethod.countryMoreM.rawValue)) { self.filterMethod = .countryMoreM },
                .default(Text(FilterMethod.sizeOne.rawValue)) { self.filterMethod = .sizeOne },
                .default(Text(FilterMethod.sizeTwo.rawValue)) { self.filterMethod = .sizeTwo },
                .default(Text(FilterMethod.sizeThree.rawValue)) { self.filterMethod = .sizeThree },
                .default(Text(FilterMethod.priceOne.rawValue)) { self.filterMethod = .priceOne },
                .default(Text(FilterMethod.priceTwo.rawValue)) { self.filterMethod = .priceTwo },
                .default(Text(FilterMethod.priceThree.rawValue)) { self.filterMethod = .priceThree },
                .default(Text(FilterMethod.none.rawValue)) { self.filterMethod = .none },
                .cancel()
            ])
        }
    }
    
  
    var body: some View {
        NavigationView {
            List(transformedResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(Color.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: sortButton, trailing: filterButton)
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
