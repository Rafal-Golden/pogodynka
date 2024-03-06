//
//  SearchViewModel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

struct CityModel {
    let name: String
    let lat, lon: Double
}

class SearchViewModel {
    var matchRegExp: String
    var bgColor: UIColor
    var title: String
    
    @Published var cities: [CityModel] = []
    
    var weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        matchRegExp = "^([a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+(?: )?)+$"
        bgColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        title = "Search your city"
        self.weatherRepository = weatherRepository
    }
    
    func searchCities(with searchPhrase: String) {
        guard searchPhrase.count > 0 else {
            self.cities = []
            return
        }
            
        weatherRepository.getLocationInfos(query: searchPhrase) { [weak self] result in
            switch result {
                case .success(let locations):
                    let newCities = locations.map {
                        CityModel(name: $0.name, lat: $0.lat, lon: $0.lon)
                    }
                    self?.cities = newCities
                    
                case .failure(let error):
                    self?.cities = []
            }
        }
    }
    
    func city(at indexPath: IndexPath) -> CityModel? {
        guard indexPath.row > -1 && indexPath.row < cities.count else {
            return nil
        }
        return cities[indexPath.row]
    }
}
