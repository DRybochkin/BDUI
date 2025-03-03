//
//  BDUI.Layout.Anchor.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI {
    
    struct Anchor: Decodable {
        
        // MARK: - Properties
        
        let elementId: String
        let type: AnchorType
    }
}
