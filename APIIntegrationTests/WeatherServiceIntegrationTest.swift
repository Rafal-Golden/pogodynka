//
//  WeatherServiceIntegrationTest.swift
//  WeatherServiceIntegrationTest
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import XCTest
import Nimble
@testable import Pogodynka

final class WeatherServiceIntegrationTest: XCTestCase {
    
    var sut: WeatherService!

    override func setUp() {
        super.setUp()
        sut = WeatherService()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_getLocations_returnsData() {
        
        var locationInfos: [LocationInfo] = []
        
        sut.requestDirectLocations(query: "Dąbrowa", limit: 5, completion: { result in
            locationInfos = (try? result.get()) ?? []
        })
        expect(locationInfos).toEventuallyNot(beEmpty(), timeout: .seconds(3))
    }
    
    func test_getWeather_returnsData() {
        
        var weatherInfo: WeatherInfo?
        
        let wroclaw = CoreTests.LocationInfos.wroclaw
        sut.requestWeather(lat: wroclaw.lat, lon: wroclaw.lon) { result in
            weatherInfo = try? result.get()
        }
        expect(weatherInfo).toEventuallyNot(beNil(), timeout: .seconds(3))
    }
}
