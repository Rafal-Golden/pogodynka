//
//  SearchCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    internal var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController        
    }
    
    func start() {
        let searchVC = build()
        navigationController.pushViewController(searchVC, animated: true)
    }
    
    func navigate(_ destination: Destination) {
        switch destination {
            case .back:
                break
            case .weatherDetails(let city):
                let coordinator = DetailsCoordinator(navigationController: navigationController, cityModel: city)
                coordinator.start()
                children.append(coordinator)
                break
        }
    }
    
    func build() -> UIViewController {
        let repository = AppMainModule.injectWeatherRepository()
        let searchHistory = AppMainModule.injectSearchHistoryStorage()
        let isPL = Bundle.main.preferredLocalizations.first?.contains("pl") == true
        
        let searchViewController = SearchViewController()
        searchViewController.model = SearchViewModel(weatherRepository: repository, searchHistory: searchHistory, isPL: isPL)
        searchViewController.goToWeatherDetails = { [weak self] cityModel in
            self?.navigate(.weatherDetails(city: cityModel))
        }
        return searchViewController
    }
}
