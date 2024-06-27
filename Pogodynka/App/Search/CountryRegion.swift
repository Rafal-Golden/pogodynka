//
//  CountryRegion.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 26/06/2024.
//

import Foundation
import MapKit

struct CountryRegion {
    let region: MKCoordinateRegion
    
    init() {
        let polandCenter = CLLocationCoordinate2D(latitude: 52.65078717798373, longitude: 19.155456342231933)
        let polandSpan = MKCoordinateSpan(latitudeDelta: 8.785257133633188, longitudeDelta: 9.936583422507208)
        
        region = MKCoordinateRegion.init(center: polandCenter, span: polandSpan)
    }
}
