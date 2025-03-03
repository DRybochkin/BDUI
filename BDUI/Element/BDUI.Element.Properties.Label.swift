//
//  BDUI.Element.Properties.Label.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI.Element.Properties {

    struct Label: Codable, Equatable {
        
        // MARK: - Properties
        
        let text: String?
        let color: String?
        let backgroundColor: String?
        let numberOfLines: Int
        let font: BDUI.Font
        let lineBreakMode: BDUI.LineBreakMode
        let textAligment: BDUI.TextAlignment
        
        // MARK: - Initializations
        
        init(text: String? = nil,
             numberOfLines: Int = 0,
             backgroundColor: String? = nil,
             color: String? = nil,
             font: BDUI.Font = BDUI.Font(family: .system(size: 17, weight: .regular), lineHeight: 21, textStyle: .title1),
             lineBreakMode: BDUI.LineBreakMode = .byTruncatingTail,
             textAligment: BDUI.TextAlignment = .natural) {
            self.backgroundColor = backgroundColor
            self.text = text
            self.numberOfLines = numberOfLines
            self.font = font
            self.lineBreakMode = lineBreakMode
            self.color = color
            self.textAligment = textAligment
        }
    }
}
