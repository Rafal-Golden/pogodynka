//
//  WeatherInfo.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import Foundation

struct WeatherInfo: Codable, Equatable {
    var sys: Sys
    var name: String
    var dt: Date
    var weather: [Weather]
    var main: Main
    
    struct Sys: Codable, Equatable {
        var sunrise: Date
        var sunset: Date
        var country: String
    }
    
    struct Weather: Codable, Equatable {
        var description: String
        var icon: String
    }
    
    struct Main: Codable, Equatable {
        var temp, tempMin, tempMax, feelsLike: Double
        var pressure, humidity: Int
    }
}
