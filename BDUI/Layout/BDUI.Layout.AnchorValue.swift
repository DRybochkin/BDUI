//
//  BDUI.Layout.AnchorValue.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Layout {
    
    enum AnchorValue: Decodable {
        
        // MARK: - Cases
        
        case offset(CGFloat)
        case multiply(CGFloat)
    }
}
