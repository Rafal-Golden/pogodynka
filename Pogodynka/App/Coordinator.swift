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
}

protocol Coordinator {
    func start()
    func navigate(_ destination: Destination)
    
    var children: [Coordinator] { get set }
}
