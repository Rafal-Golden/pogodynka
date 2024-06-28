//
//  MapViewDecorator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 28/06/2024.
//

import Foundation
import MapKit

class MapViewDecorator {
    private let mapView: MKMapView
    private var originalRegion: MKCoordinateRegion?
    
    init(mapView: MKMapView) {
        self.mapView = mapView
    }
    
    func add(mapPoint: MapPoint) {
        if originalRegion == nil {
            originalRegion = mapView.region
        }
        
        self.mapView.addAnnotation(mapPoint.annotation)
        self.mapView.setRegion(mapPoint.region, animated: true)
    }
    
    func removeMapPoint() {
        if let last = self.mapView.annotations.last {
            self.mapView.removeAnnotation(last)
        }
        
        if let originalRegion {
            mapView.setRegion(originalRegion, animated: true)
        }
    }
}
