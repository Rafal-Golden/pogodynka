//
//  CoreTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import XCTest

@testable import Pogodynka

struct CoreTests {
    
    struct NSErrors {
        static let unknown = NSError(domain: "Unknown domain - UnitTest", code: 999, userInfo: [NSLocalizedDescriptionKey: "Unknown description"])
        static let generalError = NSError(domain: "UnitTest.Error", code: 111, userInfo: [NSLocalizedDescriptionKey: "General Error used for unit testing"])
    }
    
    // Define constants for sample cities
    static let wroclawCity = (name: "Wrocław", lat: 51.111532963657154, lon: 17.03922093191807, country: "PL", state: "Dolnośląskie")
    static let dabrowaCity = (name: "Dąbrowa", lat: 53.40802735, lon: 20.2072225551886, country: "PL", state: "Warmińsko Mazurskie")
    
    struct LocationInfos {
        static let wroclaw = LocationInfo(name: wroclawCity.name, lat: wroclawCity.lat, lon: wroclawCity.lon, country: "PL", state: "Dolnośląskie")
        static let dabrowa = LocationInfo(name: dabrowaCity.name, lat: dabrowaCity.lat, lon: dabrowaCity.lon, country:"PL", state: "Warmińsko Mazurskie")
        static let locations = [wroclaw, dabrowa]
    }
    
    struct CityModels {
        static let wroclaw = CityModel(name: "Wrocław", lat: wroclawCity.lat, lon: wroclawCity.lon, state: "Dolnośląskie", isPL: true)
        static let dabrowa = CityModel(name: dabrowaCity.name, lat: dabrowaCity.lat, lon: dabrowaCity.lon, state: "Warmińsko Mazurskie", isPL: true)
    }
    
    struct WeatherInfos {
        static let wroclawSunny: WeatherInfo = decodeObject(fileName: "weather_info")
    }
    struct ForecastInfos {
        static let wroclawForecast: ForecastInfo = decodeObject(fileName: "forecast_info")
    }
    
    struct MapPoints {
        static let wroclaw = MapPoint(lat: wroclawCity.lat, lon: wroclawCity.lon, title: wroclawCity.name)
        static let dabrowa = MapPoint(lat: dabrowaCity.lat, lon: dabrowaCity.lon, title: wroclawCity.name)
    }
}

extension CoreTests {
    
    class DummyClass {}
    
    static func decodeObject<T: Codable>(fileName: String) -> T {
        do {
            let data = try dataFromFile(fileName)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            return try decoder.decode(T.self, from: data)
        }
        catch(let error) {
            XCTFail("Test error : Failed during decoding dummy object from JSON!")
            fatalError("Failed during decoding dummy object from JSON! Error \(error)")
        }
    }
    
    static func dataFromFile(_ fileName: String) throws -> Data {
        let url = Bundle(for: DummyClass.self).url(forResource: fileName, withExtension: "json")!
        return try Data(contentsOf: url)
    }
}
