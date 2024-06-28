//
//  LocalSearchIntegrationTests.swift
//  APIIntegrationTests
//
//  Created by Rafal Korzynski on 28/06/2024.
//

import XCTest
import Nimble
@testable import Pogodynka

final class LocalSearchIntegrationTests: XCTestCase {

    var sut: MapSearchEngine!

    override func setUp() {
        super.setUp()
        sut = MapSearchEngine()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_localSearchForCityName_returnsInfo() {
        var completionCalled = false
        var returnedMapPoint: MapPoint?
        var dlat: Double = 0.5
        var dlon: Double = 0.5
        
        let wroclawLoc = CoreTests.LocationInfos.wroclaw.location
        
        sut.searchForCity(name: "Wrocław") { result in
            if case .success(let mapPoint) = result {
                returnedMapPoint = mapPoint
                dlat = abs(wroclawLoc.lat - mapPoint.lat)
                dlon = abs(wroclawLoc.lon - mapPoint.lon)
            }
            completionCalled = true
        }
        
        expect(completionCalled).toEventually(beTrue())
        expect(returnedMapPoint).toEventuallyNot(beNil())
        expect(dlat).toEventually(beLessThan(0.15))
        expect(dlon).toEventually(beLessThan(0.15))
    }
}
