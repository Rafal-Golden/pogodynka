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
    
    // MARK: - TESTS -

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
        let expectedResult = [CoreTests.LocationInfos.wroclaw]
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
    
    func test_getWeatherInfo_returnsError() {
        let expectedError = CoreTests.NSErrors.generalError
        serviceMock.weatherResult = .failure(CoreTests.NSErrors.generalError)
        var completionCalled = false
        var returnedError: NSError?
        
        let wroclaw = CoreTests.LocationInfos.wroclaw
        
        sut.getWeatherInfo(lat: wroclaw.lat, lon: wroclaw.lon) { result in
            switch result {
                case .success(_):
                    break
                case .failure(let error):
                    completionCalled = true
                    returnedError = error
            }
        }
        
        expect(self.serviceMock.requestWeatherCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        expect(returnedError).to(equal(expectedError))
    }
    
    func test_getWeatherInfo_returnsWheatherInfo() {
        let expectedWeatherInfo = CoreTests.WeatherInfos.wroclawSunny
        serviceMock.weatherResult = .success(expectedWeatherInfo)
        var completionCalled = false
        var returnedWeatherInfo: WeatherInfo?
        
        let wroclaw = CoreTests.LocationInfos.wroclaw
        
        sut.getWeatherInfo(lat: wroclaw.lat, lon: wroclaw.lon) { result in
            switch result {
                case .success(let weather):
                    returnedWeatherInfo = weather
                    completionCalled = true
                case .failure(_):
                    break
            }
        }
        
        expect(self.serviceMock.requestWeatherCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        expect(returnedWeatherInfo).to(equal(expectedWeatherInfo))
        expect(returnedWeatherInfo?.name).to(equal(wroclaw.name))
    }
    
    func test_getForecastInfo_returnsError() {
        let expectedError = CoreTests.NSErrors.generalError
        serviceMock.forecastResult = .failure(expectedError)
        let wroclawLoc = CoreTests.LocationInfos.wroclaw.location
        var completionCalled: Bool = false
        var returnedError: NSError?
        
        sut.getForecastInfo(location: wroclawLoc) { result in
            switch result {
                case .failure(let error):
                    completionCalled = true
                    returnedError = error
                case .success(_):
                    break
            }
        }
        
        expect(self.serviceMock.requestForecastCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        expect(returnedError).to(equal(expectedError))
    }
    
    func test_getForecastInfo_returnsForecastInfo() {
        let expectedForecastInfo = CoreTests.ForecastInfos.wroclawForecast
        serviceMock.forecastResult = .success(expectedForecastInfo)
        var completionCalled: Bool = false
        let wroclawLoc = CoreTests.LocationInfos.wroclaw.location
        var returnedForecastInfo: ForecastInfo?
        
        sut.getForecastInfo(location: wroclawLoc) { result in
            switch result {
                case .success(let forecast):
                    completionCalled = true
                    returnedForecastInfo = forecast
                case .failure(_):
                    break
            }
        }
        
        expect(self.serviceMock.requestForecastCalled).to(beTrue())
        expect(completionCalled).to(beTrue())
        expect(returnedForecastInfo).toNot(beNil())
        expect(returnedForecastInfo).to(equal(expectedForecastInfo))
    }
}
