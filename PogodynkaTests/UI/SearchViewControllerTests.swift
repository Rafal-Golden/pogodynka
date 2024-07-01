//
//  SearchViewControllerTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 26/06/2024.
//

import XCTest
import Nimble
import MapKit

@testable import Pogodynka

final class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    var stubbedModel: SearchViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        stubbedModel = prepareStubbedModel()
        
        sut = SearchViewController()
        sut.model = stubbedModel
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    // MARK: - helpers
    
    func prepareStubbedModel() -> SearchViewModel {
        let storageMock = UserDefaultsStorageMock()
        let searchHistory = SearchHistoryStorage(storage: storageMock, maxCount: 1)
        let serviceMock = WeatherServiceMock()
        let repository = WeatherRepository(service: serviceMock)
        return SearchViewModel(weatherRepository: repository, searchHistory: searchHistory, isPL: true)
    }
    
    func getMapView() -> UIView? {
        return sut.view.subviews.first { $0 is MKMapView }
    }
    
    // MARK: - tests

    func test_AddCountryMapView_IsAddedToView() throws {
        sut.addCountryMapView()
        
        let containsMapView = getMapView() != nil
                
        expect(containsMapView).to(beTrue())
    }
    
    func test_WhenViewDidLoad_MapIsAddedToView() throws {
        sut.viewDidLoad()
        
        let containsMapView = getMapView() != nil
                
        expect(containsMapView).to(beTrue())
    }
    
    func test_AddCountryMapView_IsAnchoredToTop() throws {
        sut.addCountryMapView()
        
        let mapView = getMapView()
        let containsTopAnchor = sut.view.constraints.contains {
            ($0.firstAnchor === sut.topMapAnchor && $0.secondItem === mapView) || ($0.secondAnchor === sut.topMapAnchor && $0.firstItem === mapView )
        }
        
        expect(containsTopAnchor).to(beTrue())
    }
    
    func test_AddCountryMapView_PolandRegionIsSet() throws {
        let polandRegion = CountryRegion()
        sut.model.countryRegion = polandRegion
        let expectedRegion = CountryRegion().region
        
        sut.addCountryMapView()
        
        let mapView = try XCTUnwrap(getMapView() as? MKMapView)
        mapView.delegate?.mapView?(mapView, regionDidChangeAnimated: false)
        let currentRegion = mapView.region
        
        expect(currentRegion.center.latitude).to(equal(expectedRegion.center.latitude))
        expect(currentRegion.center.longitude).to(equal(expectedRegion.center.longitude))
    }
}
