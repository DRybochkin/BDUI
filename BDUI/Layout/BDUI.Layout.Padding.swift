//
//  BDUI.Layout.Padding.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 01.03.2025.
//

import Foundation

extension BDUI.Layout {
    
    struct Padding: Codable, Equatable {

        // MARK: - Properties
        
        static let empty: Padding = Padding(top: .absolute(0), left: .absolute(0), bottom: .absolute(0), right: .absolute(0))

        let top: Value
        let left: Value
        let bottom: Value
        let right: Value
        
        // MARK: - Initializations
        
        init(top: Value = .absolute(0), left: Value = .absolute(0), bottom: Value = .absolute(0), right: Value = .absolute(0)) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
        
        // MARK: - Functions
        
        static func simple(value: Value) -> Padding {
            Padding(top: value, left: value, bottom: value, right: value)
        }
    }
}
