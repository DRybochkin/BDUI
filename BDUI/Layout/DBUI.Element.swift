//
//  DBUI.Element.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI {
    
    struct Element: Decodable {
        
        // MARK: - Propertis
        
        let elementId: String
        let elementType: Item
        let layout: Layout
        let elements: [Self]
    }
}
