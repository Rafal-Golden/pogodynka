//
//  AppNavigator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 14/08/2024.
//

import UIKit

protocol NavigatorActions {
    func present(_ vc: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
}

protocol Navigator {
    func navigate(_ destination: Destination)
}

class AppNavigator: Navigator, NavigatorActions {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(_ destination: Destination) {
        switch destination {
            case .back:
                dismiss(animated: true)
            
            default: break
        }
    }
    
    // MARK: - Navigator actions -
    
    func present(_ vc: UIViewController, animated: Bool) {
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
