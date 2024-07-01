//
//  SearchViewModel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit
import Combine

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
    
    @Published var markedMapPoint: MapPoint?
    private(set) var mapSearchEngine: MapSearchEngine = .init()
    
    private var weatherRepository: WeatherRepositoryProtocol
    private var searchHistoryStorage: SearchHistoryStorage
    private var isPL: Bool
    
    var matchRegExp: String
    var bgColor: UIColor
    var title: String
    var noResultsMessage: String
    
    var initialSearchPhrase: String? {
        return searchHistoryStorage.loadLast()
    }
    
    var countryRegion: CountryRegion?
    
    init(weatherRepository: WeatherRepositoryProtocol, searchHistory: SearchHistoryStorage, isPL: Bool) {
        matchRegExp = "^([a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+(?: )?)+$"
        bgColor = AppColors.background
        title = NSLocalizedString("Search your city", comment: "")
        noResultsMessage = NSLocalizedString("No results, try typing further.", comment: "")
        self.weatherRepository = weatherRepository
        self.searchHistoryStorage = searchHistory
        self.isPL = isPL
    }
    
    func searchCities(with searchPhrase: String) {
        guard searchPhrase.count > 0 else {
            cities = []
            return
        }
            
        weatherRepository.getLocationInfos(query: searchPhrase) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let locations):
                    self.cities = self.cities(from: locations)
                    
                case .failure(_):
                    self.cities = []
            }
        }
    }
    
    func searchMarker(with searchPhrase: String) {
        guard searchPhrase.count > 0 else {
            markedMapPoint = nil
            return
        }
        
        mapSearchEngine.searchForCity(name: searchPhrase) { [weak self] result in
            self?.markedMapPoint = try? result.get()
        }
    }
    
    private func cities(from locations: [LocationInfo]) -> [CityModel] {
        let newCities = locations.map {
            CityModel(name: $0.name, lat: $0.lat, lon: $0.lon, state: $0.state, isPL: isPL)
        }
        return newCities
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
    
    func findCity(loc: Location) -> CityModel? {
        return cities.first(where: { fabs($0.lat - loc.lat) > 1.0e-3 && fabs($0.lon - loc.lon) > 1.0e-3 })
    }
}
