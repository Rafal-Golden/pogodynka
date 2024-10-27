//
//  DetailsCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import UIKit

class DetailsCoordinator: Coordinator {
    
    internal var children: [Coordinator] = []
    
    private var navigator: AppNavigator
    private var cityModel: CityModel
    
    init(navigator: AppNavigator, cityModel: CityModel) {
        self.navigator = navigator
        self.cityModel = cityModel
    }
    
    func start() {
        let detailsVC = DetailsViewController()
        let repository = AppMainModule.injectWeatherRepository()
        let detailsModel = DetailsViewModel(city: cityModel, repository: repository)
        detailsModel.iconImageDownloader = IconImageDownloader()
        detailsVC.detailsModel = detailsModel
        detailsVC.goBackBlock = { [weak self] in
            self?.navigateBack()
        }
        navigator.present(detailsVC, animated: true)
    }
    
    func navigateBack() {
        navigator.navigate(.back)
    }
}
