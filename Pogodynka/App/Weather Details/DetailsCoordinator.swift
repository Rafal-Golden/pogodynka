//
//  DetailsCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import UIKit

class DetailsCoordinator: Coordinator {
    
    internal var children: [Coordinator] = []
    
    private var navigationController: UINavigationController
    private var cityModel: CityModel
    
    init(navigationController: UINavigationController, cityModel: CityModel) {
        self.navigationController = navigationController
        self.cityModel = cityModel
    }
    
    func start() {
        let detailsVC = DetailsViewController()
        let repository = AppMainModule.injectWeatherRepository()
        let detailsModel = DetailsViewModel(city: cityModel, repository: repository)
        detailsModel.iconImageDownloader = IconImageDownloader()
        detailsVC.detailsModel = detailsModel
        detailsVC.goBackBlock = { [weak self] in
            self?.navigate(.back)
        }
        navigationController.pushViewController(detailsVC, animated: true)
    }
    
    func navigate(_ destination: Destination) {
        switch destination {
            case .back:
                navigationController.popViewController(animated: true)
            
            default: break
        }
    }
}
