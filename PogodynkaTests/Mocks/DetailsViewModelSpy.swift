//
//  DetailsViewModelSpy.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import Foundation

import Combine
@testable import Pogodynka

class DetailsViewModelSpy {
    private var cancellable = Set<AnyCancellable>()
    private(set) var weather: WeatherViewModel?
    private(set) var errorInfo: String?
    
    init(model: DetailsViewModel) {
        model.$weather.sink { [weak self] newWeather in
            self?.weather = newWeather
        }.store(in: &cancellable)
        
        model.$errorInfo.sink { errorInfo in
            self.errorInfo = errorInfo
        }.store(in: &cancellable)
    }
}
