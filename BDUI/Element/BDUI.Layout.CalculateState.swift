//
//  BDUI.Layout.CalculateState.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 27.02.2025.
//

import Foundation

extension BDUI.Layout {
    
    final class CalculateState: Codable {
        
        // MARK: - Properties
        
        var x = false
        var y = false
        var width = false
        var height = false
        
        // MARK: - Functions
        
        func set(x: Bool? = nil, y: Bool? = nil, width: Bool? = nil, height: Bool? = nil) {
            if let x = x { self.x = x }
            if let y = y { self.y = y }
            if let width = width { self.width = width }
            if let height = height { self.height = height }
        }
        
        func maskAsCalculated() {
            x = true
            y = true
            width = true
            height = true
        }
    }
}

extension BDUI.Layout.CalculateState: Equatable {
    
    // MARK: - Equatable functions
    
    static func == (lhs: BDUI.Layout.CalculateState, rhs: BDUI.Layout.CalculateState) -> Bool {
        lhs.x == rhs.x
        && lhs.y == rhs.y
        && lhs.width == rhs.width
        && lhs.height == rhs.height
    }
}
 
