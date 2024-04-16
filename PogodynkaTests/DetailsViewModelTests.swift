//
//  DetailsViewModelTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import XCTest
import Nimble
@testable import Pogodynka


final class DetailsViewModelTests: XCTestCase {
    
    var sut: DetailsViewModel!
    var serviceMock: WeatherServiceMock!
    var repository: WeatherRepositoryProtocol!
    var dummyLocation: CityModel!

    override func setUp() {
        super.setUp()
        dummyLocation = CoreTests.CityModels.wroclaw
        serviceMock = WeatherServiceMock()
        repository = WeatherRepository(service: serviceMock)
        sut = DetailsViewModel(city: dummyLocation, repository: repository)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        serviceMock = nil
    }
    
    // MARK: - TESTS -

    func test_fetchWeatherFails_returnsErrorInfo() {
        let detailsSpy = DetailsViewModelSpy(model: sut)
        
        sut.weather = WeatherViewModel()
        
        sut.fetchWeather()
        
        expect(self.serviceMock.requestWeatherCalled).to(beTrue())
        expect(detailsSpy.errorInfo).toNot(beNil())
        expect(detailsSpy.weather).to(beNil())
    }
    
    func test_fetchWeatherSuccess_returnsWeather() {
        let weatherInfo = CoreTests.WeatherInfos.wroclawSunny
        serviceMock.weatherResult = .success(weatherInfo)
        let detailsSpy = DetailsViewModelSpy(model: sut)
        
        sut.errorInfo = "Unexpected error!"
        
        sut.fetchWeather()
        
        expect(self.serviceMock.requestWeatherCalled).to(beTrue())
        expect(detailsSpy.errorInfo).to(beNil())
        expect(detailsSpy.weather).toNot(beNil())
    }
}
