//
//  BDUI+UIFont.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import UIKit

extension UIFont {
    
    // MARK: - Initializations
    
    static func build(font: BDUI.Font) -> UIFont {
        switch font.family {
        case let .sans(fontName, size, weight):
            UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size, weight: Weight(weight: weight))
        case let .system(size, weight):
            UIFont.systemFont(ofSize: size, weight: Weight(weight: weight))
        }
    }
}
