//
//  NoResultLabel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 08/03/2024.
//

import UIKit

class NoResultLabel: UIView {
    
    init(text: String, textColor: UIColor, backgroundColor: UIColor, padding: CGFloat) {
        super.init(frame: .zero)
        
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = .clear
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        self.addSubview(label)
        
        // Add constraints for label within the container view with padding
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
