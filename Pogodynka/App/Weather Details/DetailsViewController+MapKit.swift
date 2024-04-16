//
//  DetailsViewController+MapKit.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 16/04/2024.
//

import MapKit

extension DetailsViewController {
    
    func addMapView(mapPoint: MapPoint, topAnchor: NSLayoutYAxisAnchor) {
        let mapFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.25)
        let mapView = MKMapView(frame: mapFrame)
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mapView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
        
        mapView.addAnnotation(mapPoint.annotation)
        mapView.setRegion(mapPoint.region, animated: true)
    }
}
