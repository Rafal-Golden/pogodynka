//
//  CoreTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import Foundation

@testable import Pogodynka

struct CoreTests {
    struct NSErrors {
        static let unknown = NSError(domain: "Unknown domain - UnitTest", code: 999, userInfo: [NSLocalizedDescriptionKey: "Unknown description"])
        static let generalError = NSError(domain: "UnitTest.Error", code: 111, userInfo: [NSLocalizedDescriptionKey: "General Error used for unit testing"])
    }
    
    struct LocationInfos {
        struct Sample {
            static let wroclaw = LocationInfo(name: "Wrocław", lat: 50.96, lon: 16.96, country: "PL", state: "Dolnyśląsk")
            static let dabrowa = LocationInfo(name: "Dąbrowa", lat: 53.40802735, lon: 20.2072225551886, country:"PL", state: "Warmińsko Mazurskie")
            static let locations = [wroclaw, dabrowa]
        }
    }
}
