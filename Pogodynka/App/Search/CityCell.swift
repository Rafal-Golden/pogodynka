//
//  CityCell.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import UIKit

class CityCell: UITableViewCell {
    
    static let id = "CityCellID"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: CityModel?) {
        guard let model else { return }
        
        textLabel?.text = model.name + String(format: " (%0.3f, %0.3f)", model.lat, model.lon)
        accessoryType = .disclosureIndicator
    }
}
