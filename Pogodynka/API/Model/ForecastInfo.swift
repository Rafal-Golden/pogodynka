//
//  ForecastInfo.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 10/05/2024.
//

import Foundation

struct ForecastItem: Codable, Equatable {
    var dt: Date
    
    let main: Main
    let weather: [Weather]
    let sys: Sys
    
    struct Sys: Codable, Equatable {
        let pod: Pod
        
        enum Pod: String, Codable {
            case day = "d", night = "n"
        }
    }
    
    struct Weather: Codable, Equatable {
        let id: Int
        let main: String
        let description: String
        var icon: String
    }
    
    struct Main: Codable, Equatable {
        var temp, tempMin, tempMax, feelsLike: Double
        var pressure, humidity: Int
    }
}

struct ForecastInfo: Codable, Equatable {
    var listCount: Int
    var list: [ForecastItem]
    
    enum CodingKeys: String, CodingKey {
        case listCount = "cnt"
        case list
    }
}
