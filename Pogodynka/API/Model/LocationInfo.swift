//
//  LocationInfo.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import Foundation

public struct LocationInfo: Codable, Equatable {
    
    var name: String
    var lat, lon: Double
    var country: String
    var state: String?
}
