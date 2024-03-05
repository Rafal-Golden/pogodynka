//
//  AppCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private(set) var navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController.init()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let coordinator = SearchCoordinator()
        let searchVC = coordinator.build()
        navigationController.viewControllers = [searchVC]
    }
    
    func navigate(_ destination: Destination) {
    }
}
