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
        let searchViewController = SearchViewController()
        let repository = AppMainModule.injectWeatherRepository()
        let searchHistory = AppMainModule.injectSearchHistoryStorage()
        searchViewController.model = SearchViewModel(weatherRepository: repository, searchHistory: searchHistory)
        searchViewController.goToWeatherDetails = { [weak self] cityModel in
            self?.navigate(.weatherDetails(city: cityModel))
        }
        return searchViewController
    }
}
