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
    private(set) var requestDirectLocationsCalled: Bool = false
    
    func requestDirectLocations(query: String, limit: Int, completion: @escaping (Result<[Pogodynka.LocationInfo], NSError>) -> Void) {
        requestDirectLocationsCalled = true
        completion(directLocationsResult)
    }
}
