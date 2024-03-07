//
//  SearchViewModelSpy.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import Combine
@testable import Pogodynka

class SearchViewModelSpy {
    private var cancellable: AnyCancellable?
    private(set) var updatedCities: [CityModel] = []
    
    init(model: SearchViewModel) {
        cancellable = model.citiesPublisher.sink { [weak self] newCities in
            self?.updatedCities = newCities
        }
    }
}
