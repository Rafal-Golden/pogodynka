//
//  WeatherRepositoryTest.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import XCTest
import Nimble
@testable import Pogodynka


final class WeatherRepositoryTest: XCTestCase {
    
    var sut: WeatherRepository!
    var serviceMock: WeatherServiceMock!

    override func setUp() {
        super.setUp()
        serviceMock = WeatherServiceMock()
        sut = WeatherRepository(service: serviceMock)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        serviceMock = nil
    }

    func test_getLocationsFailure_returnsError() {
        let expectedError = CoreTests.NSErrors.generalError
        serviceMock.directLocationsResult = .failure(CoreTests.NSErrors.generalError)
        var completionCalled = false
        var returnedError: NSError?
        
        sut.getLocationInfos(query: "Wrocław") { result in
            switch result {
                case .success(_):
                    break
                case .failure(let error):
                    completionCalled = true
                    returnedError = error
            }
        }
        
        expect(self.serviceMock.requestDirectLocationsCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        expect(returnedError).to(equal(expectedError))
    }
    
    func test_getLocationsFailure_returnsLocationInfo() {
        let expectedResult = [CoreTests.LocationInfos.Sample.wroclaw]
        serviceMock.directLocationsResult = .success(expectedResult)
        var completionCalled = false
        var returnedResult: [LocationInfo]?
        
        sut.getLocationInfos(query: "Wrocław") { result in
            switch result {
                case .success(let locations):
                    completionCalled = true
                    returnedResult = locations
                    break
                case .failure(_):
                    break
            }
        }
        
        expect(self.serviceMock.requestDirectLocationsCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        expect(returnedResult).to(equal(expectedResult))
    }
}
