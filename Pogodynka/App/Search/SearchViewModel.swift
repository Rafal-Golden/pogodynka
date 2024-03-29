//
//  SearchViewModel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit
import Combine

struct CityModel: Equatable {
    let name: String
    let lat, lon: Double
}

class SearchViewModel {
    
    var citiesPublisher: AnyPublisher<[CityModel], Never> {
        return citiesSubject.eraseToAnyPublisher()
    }
    var citiesCount: Int {
        return citiesSubject.value.count
    }
    
    private var citiesSubject = CurrentValueSubject<[CityModel], Never>([])
    private var cities: [CityModel] {
        set {
            citiesSubject.send(newValue)
        }
        get {
            return citiesSubject.value
        }
    }
    
    private var weatherRepository: WeatherRepositoryProtocol
    private var searchHistoryStorage: SearchHistoryStorage
    
    var matchRegExp: String
    var bgColor: UIColor
    var title: String
    var noResultsMessage: String
    
    var initialSearchPhrase: String? {
        return searchHistoryStorage.loadLast()
    }
    
    init(weatherRepository: WeatherRepositoryProtocol, searchHistory: SearchHistoryStorage) {
        matchRegExp = "^([a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+(?: )?)+$"
        bgColor = AppColors.background
        title = NSLocalizedString("Search your city", comment: "")
        noResultsMessage = NSLocalizedString("No results, try typing further.", comment: "")
        self.weatherRepository = weatherRepository
        self.searchHistoryStorage = searchHistory
    }
    
    func searchCities(with searchPhrase: String) {
        guard searchPhrase.count > 0 else {
            cities = []
            return
        }
            
        weatherRepository.getLocationInfos(query: searchPhrase) { [weak self] result in
            switch result {
                case .success(let locations):
                    let newCities = locations.map {
                        CityModel(name: $0.name, lat: $0.lat, lon: $0.lon)
                    }
                    self?.cities = newCities
                    
                case .failure(_):
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
    
    func addHistory(searchPhrase: String) {
        if searchPhrase != searchHistoryStorage.loadLast() {
            searchHistoryStorage.add(string: searchPhrase)
        }
    }
}
