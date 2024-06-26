//
//  CityCell.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 06/03/2024.
//

import UIKit

class CityCell: UITableViewCell {
    
    static let id = "CityCellID"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: CityModel?) {
        guard let model else { return }
        
        textLabel?.text = model.name
        detailTextLabel?.text = model.details
        accessoryType = .disclosureIndicator
    }
}
