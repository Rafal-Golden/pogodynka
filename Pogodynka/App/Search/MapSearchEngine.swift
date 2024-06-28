//
//  MapSearchEngine.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 27/06/2024.
//

import Foundation
import MapKit

class MapSearchEngine {
    
    static func notFoundError(message: String) -> NSError {
        return NSError(domain: "MapSearchEngine", code: 404, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    var localSearchFactory: (MKLocalSearch.Request) -> LocalSearchProtocol  = { request in
        return MKLocalSearch(request: request)
    }
    
    func searchForCity(name: String, completion: @escaping (Result<MapPoint, NSError>) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name
        
        let search = localSearchFactory(request)
        search.start { response, error in
            if let error = error as? NSError {
                completion(.failure(error))
                return
            }
            
            guard let response, let firstIem = response.mapItems.first else {
                let notFoundError = Self.notFoundError(message: "City not found for name [\(name)]")
                completion(.failure(notFoundError))
                return
            }
                        
            let placemark = firstIem.placemark
            let resultMapPoint = MapPoint(lat: placemark.coordinate.latitude, lon: placemark.coordinate.longitude, title: firstIem.name)
            completion(.success(resultMapPoint))
        }
    }
}
