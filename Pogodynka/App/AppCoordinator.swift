//
//  AppCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    
    private(set) var navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController.init()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let coordinator = SearchCoordinator(navigationController: navigationController)
        coordinator.start()
        children.append(coordinator)
    }
    
    func navigate(_ destination: Destination) {
    }
}
