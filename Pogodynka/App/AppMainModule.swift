//
//  AppMainModule.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import Foundation

struct AppMainModule {
    
    static func injectWeatherRepository() -> WeatherRepository {
        let service = WeatherService()
        return WeatherRepository(service: service)
    }
    
    static func injectSearchHistoryStorage() -> SearchHistoryStorage {
        let storage = UserDefaultsStorage()
        return SearchHistoryStorage(storage: storage, maxCount: 5)
    }
}
