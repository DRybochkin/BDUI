//
//  BDUI.Font.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import UIKit

extension BDUI {
    
    struct Font: Codable, Equatable {
        let size: CGFloat
        let fontName: String
        let lineHeight: CGFloat
        let family: Family
        let textStyle: TextStyle
        let weight: Weight
    }
}
