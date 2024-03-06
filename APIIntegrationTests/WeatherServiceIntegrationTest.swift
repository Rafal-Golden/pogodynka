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
}
