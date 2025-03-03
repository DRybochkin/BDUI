//
//  BDUI.Font.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI {
    
    struct Font: Codable, Equatable {
        
        // MARK: - Properties
        
        let family: Family
        let lineHeight: CGFloat
        let textStyle: TextStyle
    }
}
