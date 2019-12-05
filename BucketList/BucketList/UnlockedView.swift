//
//  UnlockedView.swift
//  BucketList
//
//  Created by Angel Vázquez on 04/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import MapKit
import SwiftUI

struct UnlockedView: View {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    annotations: locations)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }, label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                    })
                    .offset(x: -15, y: -15)
                }
            }
        }
    }
}

struct UnlockedView_Previews: PreviewProvider {
    static var previews: some View {
        
        UnlockedView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                     selectedPlace: .constant(MKPointAnnotation.example),
                     showingPlaceDetails: .constant(false),
                     locations: .constant([]),
                     showingEditScreen: .constant(false))
    }
}
