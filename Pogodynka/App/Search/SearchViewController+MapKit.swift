//
//  SearchViewController+MapKit.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 26/06/2024.
//

import UIKit
import MapKit

extension SearchViewController: MKMapViewDelegate {
    
    private func updateRegion(mapView: MKMapView) {
        if let countryRegion = model.countryRegion {
            mapView.setRegion(countryRegion.region, animated: false)
        }
    }
    
    func addCountryMapView() {
        addCountryMapView(topAnchor: topAnchor)
    }
    
    private func addCountryMapView(topAnchor: NSLayoutYAxisAnchor) {
        let mapFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.25)
        let mapView = MKMapView(frame: mapFrame)
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mapView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
        
        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
        
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let currentRegionCenter = mapView.region.center
        if let neededCenter = model.countryRegion?.region.center {
            if currentRegionCenter.latitude != neededCenter.latitude || currentRegionCenter.longitude != neededCenter.longitude {
                updateRegion(mapView: mapView)
            }
        }
    }
}
