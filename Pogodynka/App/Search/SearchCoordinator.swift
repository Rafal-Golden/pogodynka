//
//  SearchCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    private(set) var navigator: AppNavigator
    internal var children: [Coordinator] = []
    
    init(navigator: AppNavigator) {
        self.navigator = navigator
    }
    
    func start() {
        let searchVC = build()
        navigator.present(searchVC, animated: true)
    }
    
    func build() -> UIViewController {
        let repository = AppMainModule.injectWeatherRepository()
        let searchHistory = AppMainModule.injectSearchHistoryStorage()
        let isPL = Bundle.main.preferredLocalizations.first?.contains("pl") == true
        
        let searchViewController = SearchViewController()
        searchViewController.model = SearchViewModel(weatherRepository: repository, searchHistory: searchHistory, isPL: isPL)
        searchViewController.model.countryRegion = CountryRegion()
        searchViewController.goToWeatherDetails = { [weak self] cityModel in
            self?.navigate(weatherDetails: cityModel)
        }
        return searchViewController
    }
    
    private func navigate(weatherDetails cityModel: CityModel) {
        let coordinator = DetailsCoordinator(navigator: navigator, cityModel: cityModel)
        coordinator.start()
        children.append(coordinator)
    }
}
