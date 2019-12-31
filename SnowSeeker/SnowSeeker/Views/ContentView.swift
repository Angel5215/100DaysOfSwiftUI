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
        case sizeTwo = "Average"
        case sizeThree = "Large"
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
        .popSheet(isPresented: $showingSortSheet) {
            PopSheet(title: Text("Sort by..."), message: nil, buttons: [
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
        .popSheet(isPresented: $showingFilterSheet) {
            PopSheet(title: Text("Filter by..."), message: nil, buttons: [
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


// MARK: - PopOver workaround
// This code was taken from https://stackoverflow.com/questions/56910941/present-actionsheet-in-swiftui-on-ipad
// to present a pop over sheet from an iPad because at this time SwiftUI doesn't seem to support
// showing ActionSheets in iPads.
public extension View {
    /// Creates an `ActionSheet` on an iPhone or the equivalent `popover` on an iPad, in order to work around `.actionSheet` crashing on iPad (`FB7397761`).
    ///
    /// - Parameters:
    ///     - isPresented: A `Binding` to whether the action sheet should be shown.
    ///     - content: A closure returning the `PopSheet` to present.
    func popSheet(isPresented: Binding<Bool>, arrowEdge: Edge = .bottom, content: @escaping () -> PopSheet) -> some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                popover(isPresented: isPresented, attachmentAnchor: .rect(.bounds), arrowEdge: arrowEdge, content: { content().popover(isPresented: isPresented) })
            } else {
                actionSheet(isPresented: isPresented, content: { content().actionSheet() })
            }
        }
    }
}

/// A `Popover` on iPad and an `ActionSheet` on iPhone.
public struct PopSheet {
    let title: Text
    let message: Text?
    let buttons: [PopSheet.Button]

    /// Creates an action sheet with the provided buttons.
    public init(title: Text, message: Text? = nil, buttons: [PopSheet.Button] = [.cancel()]) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }

    /// Creates an `ActionSheet` for use on an iPhone device
    func actionSheet() -> ActionSheet {
        ActionSheet(title: title, message: message, buttons: buttons.map({ popButton in
            // convert from PopSheet.Button to ActionSheet.Button (i.e., Alert.Button)
            switch popButton.kind {
            case .default: return .default(popButton.label, action: popButton.action)
            case .cancel: return .cancel(popButton.label, action: popButton.action)
            case .destructive: return .destructive(popButton.label, action: popButton.action)
            }
        }))
    }

    /// Creates a `.popover` for use on an iPad device
    func popover(isPresented: Binding<Bool>) -> some View {
        VStack {
            ForEach(Array(buttons.enumerated()), id: \.offset) { (offset, button) in
                Group {
                    SwiftUI.Button(action: {
                        // hide the popover whenever an action is performed
                        isPresented.wrappedValue = false
                        // another bug: if the action shows a sheet or popover, it will fail unless this one has already been dismissed
                        DispatchQueue.main.async {
                            button.action?()
                        }
                    }, label: {
                        button.label.font(.title)
                    })
                    Divider()
                }
            }
        }
    }

    /// A button representing an operation of an action sheet or popover presentation.
    ///
    /// Basically duplicates `ActionSheet.Button` (i.e., `Alert.Button`).
    public struct Button {
        let kind: Kind
        let label: Text
        let action: (() -> Void)?
        enum Kind { case `default`, cancel, destructive }

        /// Creates a `Button` with the default style.
        public static func `default`(_ label: Text, action: (() -> Void)? = {}) -> Self {
            Self(kind: .default, label: label, action: action)
        }

        /// Creates a `Button` that indicates cancellation of some operation.
        public static func cancel(_ label: Text, action: (() -> Void)? = {}) -> Self {
            Self(kind: .cancel, label: label, action: action)
        }

        /// Creates an `Alert.Button` that indicates cancellation of some operation.
        public static func cancel(_ action: (() -> Void)? = {}) -> Self {
            Self(kind: .cancel, label: Text("Cancel"), action: action)
        }

        /// Creates an `Alert.Button` with a style indicating destruction of some data.
        public static func destructive(_ label: Text, action: (() -> Void)? = {}) -> Self {
            Self(kind: .destructive, label: label, action: action)
        }
    }
}
