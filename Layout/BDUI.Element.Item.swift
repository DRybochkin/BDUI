//
//  BDUI.ElementType.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Element {
    
    enum Item: String, Decodable {
        
        // MARK: - Cases
        
        case container = "BDUIContainerView"
        case image = "BDUIImageView"
    }
}
