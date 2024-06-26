//
//  WeatherServiceMock.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import Foundation
@testable import Pogodynka

class WeatherServiceMock: WeatherServiceProtocol {
    
    var directLocationsResult: Result<[Pogodynka.LocationInfo], NSError> = .failure(CoreTests.NSErrors.unknown)
    private(set) var requestDirectLocationsCalled = false
    
    var weatherResult: Result<WeatherInfo, NSError> = .failure(CoreTests.NSErrors.unknown)
    private(set) var requestWeatherCalled = false
    
    func requestDirectLocations(query: String, limit: Int, completion: @escaping (Result<[Pogodynka.LocationInfo], NSError>) -> Void) {
        requestDirectLocationsCalled = true
        completion(directLocationsResult)
    }
    
    func requestWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherInfo, NSError>) -> Void) {
        requestWeatherCalled = true
        completion(weatherResult)
    }
    
    var forecastResult: Result<Pogodynka.ForecastInfo, NSError> = .failure(CoreTests.NSErrors.unknown)
    private(set) var requestForecastCalled = false
    
    func requestForecast(location: Pogodynka.Location, completion: @escaping (Result<Pogodynka.ForecastInfo, NSError>) -> Void) {
        requestForecastCalled = true
        completion(forecastResult)
    }
}
