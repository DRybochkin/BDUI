//
//  BDUI+NSLineBreakMode.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import UIKit

extension NSLineBreakMode {
    
    // MARK: - Initializations
    
    init(lineBreakMode: BDUI.LineBreakMode) {
        switch lineBreakMode {
        case .byWordWrapping:
            self = .byWordWrapping
        case .byCharWrapping:
            self = .byCharWrapping
        case .byClipping:
            self = .byClipping
        case .byTruncatingHead:
            self = .byTruncatingHead
        case .byTruncatingTail:
            self = .byTruncatingTail
        case .byTruncatingMiddle:
            self = .byTruncatingMiddle
        }
    }
}
