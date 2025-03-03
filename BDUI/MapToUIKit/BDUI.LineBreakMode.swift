//
//  BDUI.LineBreakMode.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI {

    enum LineBreakMode: Int, Codable, Equatable {
        
        // MARK: - Cases
        
        case byWordWrapping = 0
        case byCharWrapping = 1
        case byClipping = 2
        case byTruncatingHead = 3
        case byTruncatingTail = 4
        case byTruncatingMiddle = 5
    }
}
