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

    override func setUp() {
        super.setUp()
        serviceMock = WeatherServiceMock()
        repository = WeatherRepository(service: serviceMock)
        sut = SearchViewModel(weatherRepository: repository)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        repository = nil
        serviceMock = nil
    }

    func test_init_returnsEmptyCities() {
        expect(self.sut.cities).to(beEmpty())
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
    
    func test_searchCities_returnNothing() {
        sut.searchCities(with: "")
        expect(self.sut.cities).to(beEmpty())
    }
}
