//
//  WeatherRepository.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func getLocationInfos(query: String, comletion: @escaping (Result<[LocationInfo], NSError>) -> Void)
    func getWeatherInfo(lat: Double, lon: Double, completion: @escaping (Result<WeatherInfo, NSError>) -> Void)
    func getForecastInfo(location: Location, completion: @escaping (Result<ForecastInfo, NSError>) -> Void)
}

class WeatherRepository: WeatherRepositoryProtocol {

    private let service: WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol) {
        self.service = service
    }
    
    func getLocationInfos(query: String, comletion: @escaping (Result<[LocationInfo], NSError>) -> Void) {
        service.requestDirectLocations(query: query, limit: 5, completion: comletion)
    }
    
    func getWeatherInfo(lat: Double, lon: Double, completion: @escaping (Result<WeatherInfo, NSError>) -> Void) {
        service.requestWeather(lat: lat, lon: lon, completion: completion)
    }
    
    func getForecastInfo(location: Location, completion: @escaping (Result<ForecastInfo, NSError>) -> Void) {
        service.requestForecast(location: location, completion: completion)
    }
}
