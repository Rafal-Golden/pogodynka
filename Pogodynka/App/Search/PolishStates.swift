//
//  PolishStates.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 17/04/2024.
//

import Foundation

class PolishStates {
    private static let dict = [
        "Lower Silesian": "dolnośląskie",
        "Kuyavian-Pomeranian": "kujawsko-pomorskie",
        "Lublin": "lubelskie",
        "Lubusz": "lubuskie",
        "Łódź": "łódzkie",
        "Lesser Poland": "małopolskie",
        "Masovian": "mazowieckie",
        "Opole": "opolskie",
        "Subcarpathian": "podkarpackie",
        "Podlaskie": "podlaskie",
        "Pomeranian": "pomorskie",
        "Silesian": "śląskie",
        "Świętokrzyskie": "świętokrzyskie",
        "Warmian-Masurian": "warmińsko-mazurskie",
        "Greater Poland": "wielkopolskie",
        "West Pomeranian": "zachodniopomorskie",
    ]
    private static let voivodeshipPL = "Województwo "
    private static let voivodeshipEn = " Voivodeship"
    
    class func translate(state: String) -> String {
        let stateEng = state.replacingOccurrences(of: voivodeshipEn, with: "")
        let statePL = dict[stateEng] ?? ""
        return statePL.isEmpty ? stateEng : voivodeshipPL + statePL
    }
}
