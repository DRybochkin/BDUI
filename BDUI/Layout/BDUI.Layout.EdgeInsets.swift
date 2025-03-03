//
//  BDUI.Layout.EdgeInsets.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 02.03.2025.
//

import Foundation

extension BDUI.Layout {
    
    struct EdgeInsets: Codable, Equatable {
        
        // MARK: - Properties
        
        static let zero = EdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)

        let top: CGFloat
        let left: CGFloat
        let bottom: CGFloat
        let right: CGFloat
    }
}
