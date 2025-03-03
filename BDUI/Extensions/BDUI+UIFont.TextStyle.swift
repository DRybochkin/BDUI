//
//  BDUI+UIFont.TextStyle.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import UIKit

extension UIFont.TextStyle {
    
    // MARK: - Initializations
    
    init(textStyle: BDUI.Font.TextStyle) {
        switch textStyle {
        case .largeTitle:
            self = .largeTitle
        case .extraLargeTitle:
            self = .extraLargeTitle
        case .extraLargeTitle2:
            self = .extraLargeTitle2
        case .title1:
            self = .title1
        case .title2:
            self = .title2
        case .title3:
            self = .title3
        case .headline:
            self = .headline
        case .subheadline:
            self = .subheadline
        case .body:
            self = .body
        case .callout:
            self = .callout
        case .footnote:
            self = .footnote
        case .caption1:
            self = .caption1
        case .caption2:
            self = .caption2
        }
    }
}
