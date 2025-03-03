//
//  BDUI.ViewFactory.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

extension BDUI {
    
    enum BDUIViewFactory {
        
        // MARK: - Functions
        
        static func build(bduiElement: Element) -> UIView {
            switch bduiElement.elementType {
            case .container:
                return BDUIContainerView(bduiElement: bduiElement)
            case .image:
                return UIImageView()
            }
        }
    }
}
