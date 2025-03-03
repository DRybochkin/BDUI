//
//  DBUI.AnchorType.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI {
    
    enum AnchorType: Decodable {
        case top(AnchorValue)
        case leading(AnchorValue)
        case bottom(AnchorValue)
        case trailing(AnchorValue)
        case centerX(AnchorValue)
        case centerY(AnchorValue)
        case width(AnchorValue)
        case height(AnchorValue)
    }
}
