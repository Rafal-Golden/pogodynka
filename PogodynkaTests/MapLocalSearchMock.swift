//
//  MapLocalSearchMock.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 27/06/2024.
//

import MapKit
@testable import Pogodynka

class MapLocalSearchMock: LocalSearchProtocol {
    var startCalled = false
    var startResponse: MKLocalSearch.Response? = nil
    var startError: Error? = nil
    
    func start(completionHandler: @escaping (MKLocalSearch.Response?, Error?) -> Void) {
        completionHandler(startResponse, startError)
        startCalled = true
    }
    
    func mockedResponse(locationInfo: LocationInfo) -> MKLocalSearch.Response {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: locationInfo.lat, longitude: locationInfo.lon))
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = locationInfo.name
        let response = MKLocalSearch.Response()
        response.setValue([mapItem], forKey: "mapItems")
        return response
    }
}
