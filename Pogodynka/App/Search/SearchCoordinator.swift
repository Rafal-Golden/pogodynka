//
//  SearchCoordinator.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    func start() {
        
    }
    
    func navigate(_ destination: Destination) {
        
    }
    
    func build() -> UIViewController {
        let searchViewController = SearchViewController()
        searchViewController.model = SearchViewModel()
        return searchViewController
    }
}
