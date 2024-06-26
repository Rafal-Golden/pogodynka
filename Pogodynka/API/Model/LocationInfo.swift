//
//  LocationInfo.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import Foundation

public struct Location: Codable, Equatable {
    var lat, lon: Double
}

public struct LocationInfo: Codable, Equatable {
    
    var name: String
    var lat, lon: Double
    var country: String
    var state: String?
}

public extension LocationInfo {
    var location: Location {
        return Location(lat: self.lat, lon: self.lon)
    }
}
