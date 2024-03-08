//
//  UIColor+intValue.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 08/03/2024.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: UInt) {
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((rgb & 0xFF)) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

enum AppColors {
    
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        
        return UIColor { $0.userInterfaceStyle == .light ? light : dark }
    }
    
    enum Palette {
        
        static let primary0 = UIColor(rgb: 0x000000)
        static let primary10 = UIColor(rgb: 0x5A272D)
        
        static let neutral0 = UIColor(rgb: 0x000000)
        static let neutral10 = UIColor(rgb: 0x1D1516)
        static let neutral30 = UIColor(rgb: 0x444444)
        static let neutral95 = UIColor(rgb: 0xEEEBE8)
        static let neutral100 = UIColor(rgb: 0xFFFFFF)
    }
    
    //background
    static var background = dynamicColor(light: Palette.neutral95, dark: Palette.neutral10)
    static var body = dynamicColor(light: Palette.neutral30, dark: Palette.neutral95)
    static var hintBackground = UIColor(rgb: 0xFEC509).withAlphaComponent(0.90)
    static var hintText = dynamicColor(light: Palette.neutral10, dark: Palette.primary10)
}
