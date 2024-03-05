//
//  SearchViewModel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

struct City {
    let id: Int
    let name: String
}

class SearchViewModel {
    var matchRegExp: String
    var bgColor: UIColor
    var title: String
    
    var cities: [City] = []
    
    init() {
        matchRegExp = "^([a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+(?: )?)+$"
        bgColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        title = "Search your city"
    }
    
    func searchCities(with searchPhrase: String) {
        
    }
}
