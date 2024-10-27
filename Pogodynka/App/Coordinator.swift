//
//  Coordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import Foundation

enum Destination {
    case back
    case weatherDetails(city: CityModel)
    case search
}

protocol Coordinator {
    func start()
    
    var children: [Coordinator] { get set }
}
