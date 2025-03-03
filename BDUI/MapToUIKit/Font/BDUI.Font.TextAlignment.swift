//
//  BDUI.Font.TextAlignment.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI.Font {
    
    enum TextAlignment: Int, Codable, Equatable {
        
        // MARK: - Cases
        
        case left = 0
        case center = 1
        case right = 2
        case justified = 3
        case natural = 4
    }
}
