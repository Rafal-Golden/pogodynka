//
//  DetailsModel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import Foundation

class DetailsModel {
    var lat: Double, lon: Double
    var name: String
    
    init(lat: Double, lon: Double, name: String) {
        self.lat = lat
        self.lon = lon
        self.name = name
    }
}
