//
//  BDUI.Layout.Point.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 01.03.2025.
//

import Foundation

extension BDUI.Layout {
    
    struct Point: Codable, Equatable {
        
        // MARK: - Properties
        
        static let empty = Point(x: .empty, y: .empty)

        let x: Value
        let y: Value
    }
}
