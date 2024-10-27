//
//  AppCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    
    private var navigationController: UINavigationController
    private(set) var navigator: AppNavigator
    
    var viewControllersCount: Int {
        navigationController.viewControllers.count
    }
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController.init()
        self.navigator = AppNavigator(navigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let coordinator = SearchCoordinator(navigator: navigator)
        coordinator.start()
        children.append(coordinator)
    }
}
