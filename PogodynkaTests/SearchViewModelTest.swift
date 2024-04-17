//
//  SearchViewModelTest.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import XCTest
import Nimble
@testable import Pogodynka

final class SearchViewModelTest: XCTestCase {
    
    var sut: SearchViewModel!
    var serviceMock: WeatherServiceMock!
    var repository: WeatherRepository!
    var storageMock: UserDefaultsStorageMock!

    override func setUp() {
        super.setUp()
        storageMock = UserDefaultsStorageMock()
        let searchHistory = SearchHistoryStorage(storage: storageMock, maxCount: 3)
        serviceMock = WeatherServiceMock()
        repository = WeatherRepository(service: serviceMock)
        sut = SearchViewModel(weatherRepository: repository, searchHistory: searchHistory, isPL: true)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        repository = nil
        serviceMock = nil
        storageMock = nil
    }
    
    // MARK: - TESTS -

    func test_init_returnsEmptyCities() {
        expect(self.sut.citiesCount).to(equal(0))
    }
    
    func test_init_returnsTitle() {
        expect(self.sut.title.count).to(beGreaterThan(0))
    }
    
    func test_matchRegExps_isValid() {
        expect(self.regExpValidate(text: "12")).to(beFalse())
        expect(self.regExpValidate(text: "Wro12")).to(beFalse())
        expect(self.regExpValidate(text: "Wrocław")).to(beTrue())
        expect(self.regExpValidate(text: "Wro")).to(beTrue())
        expect(self.regExpValidate(text: "Środa śląska")).to(beTrue())
    }
    
    func regExpValidate(text: String) -> Bool {
        let validRange = text.range(of: self.sut.matchRegExp, options: .regularExpression)
        return (validRange != nil && validRange?.isEmpty == false)
    }
    
    func test_searchCities_returnsNothing() {
        let modelSpy = SearchViewModelSpy(model: sut)
        
        sut.searchCities(with: "")
        
        expect(self.sut.citiesCount).to(equal(0))
        expect(modelSpy.updatedCities).to(beEmpty())
    }
    
    func test_searchCitiesSuccess_returnsData() {
        let testedCity = [CoreTests.LocationInfos.wroclaw]
        let expectedCity = [CoreTests.CityModels.wroclaw]
        serviceMock.directLocationsResult = .success(testedCity)
        
        let modelSpy = SearchViewModelSpy(model: sut)
        
        sut.searchCities(with: "Wroclaw")
        
        expect(self.sut.citiesCount).to(beGreaterThan(0))
        expect(modelSpy.updatedCities).toNot(beEmpty())
        expect(modelSpy.updatedCities).to(equal(expectedCity))
    }
    
    func test_CityAtAfterInit_ReturnsNil() {
        let indexPath0 = IndexPath(row: 0, section: 0)
        let indexPath1 = IndexPath(row: 1, section: 0)
        
        expect(self.sut.city(at: indexPath0)).to(beNil())
        expect(self.sut.city(at: indexPath1)).to(beNil())
    }
    
    func test_CityAtAfterSearch_ReturnsCity() {
        let testedCity = [CoreTests.LocationInfos.wroclaw]
        serviceMock.directLocationsResult = .success(testedCity)
        
        sut.searchCities(with: "Wroclaw")
        
        let indexPath0 = IndexPath(row: 0, section: 0)
        let indexPath1 = IndexPath(row: 1, section: 0)
        
        expect(self.sut.city(at: indexPath0)).toNot(beNil())
        expect(self.sut.city(at: indexPath1)).to(beNil())
    }
    
    func test_CityAtAfterSearchFails_ReturnsNil() {
        sut.searchCities(with: "")
        
        let indexPath0 = IndexPath(row: 0, section: 0)
        
        expect(self.sut.city(at: indexPath0)).to(beNil())
    }
    
    func test_TwoSearchActions_ReturnsLastCity() {
        let testedCity = [CoreTests.LocationInfos.wroclaw]
        serviceMock.directLocationsResult = .success(testedCity)
        
        sut.searchCities(with: "Wroclaw")
        
        let lastTestedCity = [CoreTests.LocationInfos.dabrowa]
        serviceMock.directLocationsResult = .success(lastTestedCity)
        
        sut.searchCities(with: "Dabrowa")
        
        let indexPath0 = IndexPath(row: 0, section: 0)
        let returnedCity = sut.city(at: indexPath0)
        let expectedCity = CoreTests.CityModels.dabrowa
        
        expect(returnedCity).toNot(beNil())
        expect(returnedCity).to(equal(expectedCity))
        expect(returnedCity?.name).to(equal(expectedCity.name))
    }
}
