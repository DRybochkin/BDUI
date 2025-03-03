//
//  DBUIElement.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

struct DBUIElement: Decodable {
    
    // MARK: - Propertis
    
    let elementId: String
    let elementType: BDUIElementType
    let layout: DBUILayout
    let elements: [DBUIElement]
}
