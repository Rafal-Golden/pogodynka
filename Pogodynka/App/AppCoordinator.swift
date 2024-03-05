//
//  AppCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController.init()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let emptyVC = UIViewController()
        emptyVC.view.backgroundColor = UIColor.red
        navigationController.viewControllers = [emptyVC]
    }
    
    func navigate(_ destination: Destination) {
    }
}
