//
//  MapSearchEngineTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 27/06/2024.
//

import XCTest
import Nimble

@testable import Pogodynka

final class MapSearchEngineTests: XCTestCase {
    
    var sut: MapSearchEngine!
    var localSearchMock: MapLocalSearchMock!
    
    override func setUp() {
        super.setUp()
        
        localSearchMock = MapLocalSearchMock()
        sut = MapSearchEngine()
        sut.localSearchFactory = { _ in
            return self.localSearchMock
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        localSearchMock = nil
    }
    
    // MARK: - tests
    
    func test_searchForCity_failsWithError() {
        var completionCalled = false
        var returnedError: NSError? = nil
        let expectedError = CoreTests.NSErrors.generalError
        localSearchMock.startError = expectedError
        
        let cityName = "Wrocław"
        
        sut.searchForCity(name: cityName) { result in
            switch result {
                case .success(_):
                    break
                case .failure(let error):
                    completionCalled = true
                    returnedError = error
            }
        }
        
        expect(self.localSearchMock.startCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        
        expect(returnedError).to(equal(expectedError))
    }
    
    func test_searchForCity_successWithMapPoint() {
        var completionCalled = false
        var returnedMapPoint = MapPoint(lat: 0, lon: 0)
        
        let wroclaw = CoreTests.LocationInfos.wroclaw
        localSearchMock.startResponse = localSearchMock.mockedResponse(locationInfo: wroclaw)
        
        sut.searchForCity(name: wroclaw.name) { result in
            switch result {
                case .success(let mapPoint):
                    completionCalled = true
                    returnedMapPoint = mapPoint
                case .failure(_):
                    break
            }
        }
        
        expect(self.localSearchMock.startCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        
        expect(returnedMapPoint.lat).to(equal(wroclaw.lat))
        expect(returnedMapPoint.lon).to(equal(wroclaw.lon))
        expect(returnedMapPoint.annotation.title).to(equal(wroclaw.name))
    }
}
