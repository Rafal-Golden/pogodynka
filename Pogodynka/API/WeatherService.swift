//
//  WeatherService.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import Foundation

protocol WeatherServiceProtocol {
    func requestDirectLocations(query: String, limit: Int, completion: @escaping (Result<[LocationInfo], NSError>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    
    private let requestService: APIRequestService
    let appidItem: URLQueryItem
    let langItem: URLQueryItem
    
    private var directLocationsTask: URLSessionDataTask?
    
    public init(requestService: APIRequestService, language: String) {
        self.requestService = requestService
        self.appidItem = URLQueryItem(name: "appid", value: "8bb56e20ee53958487240aec70a7697b")
        self.langItem = URLQueryItem(name: "lang", value: language)
    }
    
    public func requestDirectLocations(query: String, limit: Int, completion: @escaping (Result<[LocationInfo], NSError>) -> Void) {
        let path = "http://api.openweathermap.org/geo/1.0/direct"
        let queryItems = basicQueryItems(with: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "limit", value: "\(limit)"),
        ])
        let request = requestService.request(method: "GET", path: path, queryItems: queryItems)
        directLocationsTask?.cancel()
        directLocationsTask = requestService.runJson(request: request) { result in
            completion(result)
        }
    }
    
    // MARK: - Helpers -
    
    private func basicQueryItems(with: [URLQueryItem]) -> [URLQueryItem] {
        var basicItems: [URLQueryItem] = [
            appidItem,
            langItem,
        ]
        basicItems.append(contentsOf: with)
        return basicItems
    }
}

extension WeatherService {
    convenience init() {
        self.init(requestService: APIRequestService(), language: "PL")
    }
}
