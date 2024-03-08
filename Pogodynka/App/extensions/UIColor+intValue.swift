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
        
        static let blue90 = UIColor(rgb: 0x084AD9)
        static let blue10 = UIColor(rgb: 0x08D4FF)
        
        static let red90 = UIColor(rgb: 0xC52600)
        static let red10 = UIColor(rgb: 0xFFA4A5)
        
        static let orange60 = UIColor(rgb: 0xFEC509)
    }
    
    //background
    static var background = dynamicColor(light: Palette.neutral95, dark: Palette.neutral10)
    static var body = dynamicColor(light: Palette.neutral30, dark: Palette.neutral95)
    static var hintBackground = Palette.orange60.withAlphaComponent(0.90)
    static var hintText = dynamicColor(light: Palette.neutral10, dark: Palette.primary10)
    
    static var tempBlack = body
    static var tempBlue = dynamicColor(light: Palette.blue90, dark: Palette.blue10)
    static var tempRed = dynamicColor(light: Palette.red90, dark: Palette.red10)
}
