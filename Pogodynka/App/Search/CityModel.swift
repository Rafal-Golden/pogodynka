//
//  CityModel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 17/04/2024.
//

import Foundation

struct CityModel: Equatable {
    let name: String
    let lat, lon: Double
    let state: String?
    let isPL: Bool
    var details: String {
        let baseState = isPL ? statePL : state
        guard let baseState else {
            return String(format: " (%0.3f, %0.3f)", lat, lon)
        }
        return baseState
    }
}

extension CityModel {
    var statePL: String? {
        guard let state else { return nil }
        return PolishStates.translate(state: state)
    }
}
