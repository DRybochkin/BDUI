//
//  BDUI.Font.TextStyle.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI.Font {
    
    enum TextStyle: String, Codable, Equatable {
        
        // MARK: - Cases
        
        case largeTitle
        case extraLargeTitle
        case extraLargeTitle2
        case title1
        case title2
        case title3
        case headline
        case subheadline
        case body
        case callout
        case footnote
        case caption1
        case caption2
    }
}
