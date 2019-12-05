//
//  MKPointAnnotation-Codable.swift
//  BucketList
//
//  Created by Angel Vázquez on 04/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import MapKit

class CodableMKPointAnnotation: MKPointAnnotation, Codable {
    enum CodingKeys: CodingKey {
        case title, subtitle, latitude, longitude
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)

        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wrappedTitle, forKey: .title)
        try container.encode(wrappedSubtitle, forKey: .subtitle)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}
