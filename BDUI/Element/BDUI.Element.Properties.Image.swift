//
//  BDUI.Element.Properties.Image.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI.Element.Properties {
    
    struct Image: Codable, Equatable {
        
        // MARK: - Properties
        
        let backgroundColor: String?
        let cornerRadius: CGFloat?
        let image: String?
        let clipToBounds: Bool

        // MARK: - Initializations
        
        init(backgroundColor: String? = nil, cornerRadius: CGFloat? = nil, image: String? = nil, clipToBounds: Bool = false) {
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.image = image
            self.clipToBounds = clipToBounds
        }
    }
}
