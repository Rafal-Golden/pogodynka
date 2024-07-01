//
//  MapViewDecoratorTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 28/06/2024.
//

import XCTest
import MapKit
import Nimble

@testable import Pogodynka

final class MapViewDecoratorTests: XCTestCase {

    var mapView: MKMapViewStub!
    var decorator: MapViewDecorator!
    
    override func setUp() {
        super.setUp()
        mapView = MKMapViewStub()
        decorator = MapViewDecorator(mapView: mapView)
    }
    
    override func tearDown() {
        mapView = nil
        decorator = nil
        super.tearDown()
    }
    
    // MARK: - Helpers
    
    func equalRegions(_ reg1: MKCoordinateRegion, _ reg2: MKCoordinateRegion) -> Bool {
        return reg1.center.latitude == reg2.center.latitude &&
            reg1.center.longitude == reg2.center.longitude &&
            reg1.span.latitudeDelta == reg2.span.latitudeDelta &&
            reg1.span.longitudeDelta == reg2.span.longitudeDelta
    }
    
    // MARK: - Tests
    
    func test_AddMapPointToMapView() {
        let wroclaw = CoreTests.LocationInfos.wroclaw
        let mapPoint = MapPoint(lat: wroclaw.lat, lon: wroclaw.lon, title: wroclaw.name)
        
        decorator.add(mapPoint: mapPoint)
        
        expect(self.mapView.annotations).toNot(beEmpty())
        
        let annotation = mapView.annotations.first as? MKPointAnnotation
        expect(annotation?.title).to(equal(wroclaw.name))
        expect(annotation?.coordinate.latitude).to(equal(wroclaw.lat))
        expect(annotation?.coordinate.longitude).to(equal(wroclaw.lon))
        expect(annotation?.title).to(equal(wroclaw.name))
    }
    
    func test_RemoveMapPointFromMapView() {
        let wroclaw = CoreTests.LocationInfos.wroclaw
        let mapPoint = MapPoint(lat: wroclaw.lat, lon: wroclaw.lon, title: wroclaw.name)
        
        decorator.add(mapPoint: mapPoint)
        decorator.removeMapPoint()
        
        expect(self.mapView.annotations).to(beEmpty())
    }
    
    func test_AddAndRemoveSequence_PreservesRegionValue() {
        let dabrowa = CoreTests.MapPoints.dabrowa
        
        let initalRegion = self.mapView.region
                
        decorator.add(mapPoint: dabrowa)
        
        let isDabrowaRegionSet = equalRegions(mapView.updatedRegion, dabrowa.region)
        expect(isDabrowaRegionSet).to(beTrue())
        
        let regionIsEqualAfterAdd = equalRegions(mapView.updatedRegion, initalRegion)
        expect(regionIsEqualAfterAdd).to(beFalse())
        
        decorator.removeMapPoint()
        
        let regionIsEqualAfterRemove = equalRegions(mapView.region, initalRegion)
        expect(regionIsEqualAfterRemove).to(beTrue())
    }
}

class MKMapViewStub: MKMapView {
    var updatedRegion = MKCoordinateRegion()
        
    override func setRegion(_ region: MKCoordinateRegion, animated: Bool) {
        updatedRegion = region
        super.setRegion(region, animated: animated)
    }
}
