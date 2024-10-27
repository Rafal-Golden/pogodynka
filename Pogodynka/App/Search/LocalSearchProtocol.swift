//
//  LocalSearchProtocol.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 27/06/2024.
//

import MapKit

protocol LocalSearchProtocol {
    func start(completionHandler: @escaping @MainActor @Sendable (MKLocalSearch.Response?, (any Error)?) -> Void)
}

extension MKLocalSearch: LocalSearchProtocol {}
