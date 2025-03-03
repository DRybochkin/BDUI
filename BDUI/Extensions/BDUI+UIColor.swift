//
//  BDUI.UIColor.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import UIKit

extension UIColor {
    
    // MARK: - Initializations
    
    convenience init?(hex: String) {
        guard hex.hasPrefix("#") else { return nil }
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        let hasAlpha = hexColor.count == 8
        let validHex = hasAlpha || hexColor.count == 6
        
        guard validHex else { return nil }

        let colorWithAlpha = hasAlpha ? hexColor : hexColor + "FF"
        
        let scanner = Scanner(string: colorWithAlpha)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else { return nil }

        let red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        let green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        let blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        let alpha = hasAlpha ? CGFloat(hexNumber & 0x000000ff) / 255 : 1

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
