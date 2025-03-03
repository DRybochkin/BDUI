//
//  BDUI.Element.Properties.View.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI.Element.Properties {

    struct View: Codable, Equatable {
        
        // MARK: - Properties
        
        let backgroundColor: String?
        let cornerRadius: CGFloat?
        let clipToBounds: Bool
        
        // MARK: - Initializations
        
        init(backgroundColor: String? = nil, cornerRadius: CGFloat? = nil, clipToBounds: Bool = false) {
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.clipToBounds = clipToBounds
        }
    }
}
