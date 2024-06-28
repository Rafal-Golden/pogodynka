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

    var mapView: MKMapView!
    var decorator: MapViewDecorator!
    
    override func setUp() {
        super.setUp()
        mapView = MKMapView()
        decorator = MapViewDecorator(mapView: mapView)
    }
    
    override func tearDown() {
        mapView = nil
        decorator = nil
        super.tearDown()
    }
    
    func test_AddMapPointToMapView() {
        let wroclaw = CoreTests.LocationInfos.wroclaw
        let mapPoint = MapPoint(lat: wroclaw.lat, lon: wroclaw.lon, title: wroclaw.name)
        
        decorator.add(mapPoint: mapPoint)
        
        expect(self.mapView.annotations).to(beEmpty())
        
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
}
