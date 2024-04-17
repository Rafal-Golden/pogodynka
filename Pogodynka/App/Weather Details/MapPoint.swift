//
//  MapPoint.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 16/04/2024.
//

import MapKit

struct MapPoint {
    var lat: Double, lon: Double
    var annotation: MKPointAnnotation
    var region: MKCoordinateRegion
    
    init(lat: Double, lon: Double, annotation: MKPointAnnotation, region: MKCoordinateRegion) {
        self.lat = lat
        self.lon = lon
        self.annotation = annotation
        self.region = region
    }
}

extension MapPoint {
    
    init(lat: Double, lon: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.init(lat: lat, lon: lon, annotation: annotation, region: region)
    }
}
