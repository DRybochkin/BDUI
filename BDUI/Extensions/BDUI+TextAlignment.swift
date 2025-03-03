//
//  BDUI+TextAlignment.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import UIKit

extension NSTextAlignment {
    
    // MARK: - Initializations
    
    init(textAlignment: BDUI.TextAlignment) {
        switch textAlignment {
        case .left:
            self = .left
        case .center:
            self = .center
        case .right:
            self = .right
        case .justified:
            self = .justified
        case .natural:
            self = .natural
        }
    }
}
