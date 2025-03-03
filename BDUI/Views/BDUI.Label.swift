//
//  BDUI.Label.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 27.02.2025.
//

import UIKit

extension BDUI {
    
    final class Label: UILabel {
        
        // MARK: - Private properties
        
        private var layouter: Layouter

        // MARK: - Initializations
        
        required init(layouter: Layouter) {
            self.layouter = layouter
            super.init(frame: .zero)
            
            configure()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension BDUI.Label: BDUI.ViewLayoutProtocol {

    // MARK: - ViewLayoutProtocol properties
    
    static var identifier: String { _typeName(Self.self, qualified: false) }
    
    // MARK: - Functions
    
    func calculateFrame() {
        frame = layouter.state.frame
    }
    
    func update(layouter: BDUI.Layouter) {
        self.layouter = layouter
        calculateFrame()
    }
}

private extension BDUI.Label {
    
    // MARK: - Private functions
    
    func configure() {
        applyProperties()
    }
    
    func applyProperties() {
        switch layouter.element.properties {
        case let .label(properties):
            if let backgroundColor = properties.backgroundColor {
                self.backgroundColor = UIColor(hex: backgroundColor)
            }
            self.attributedText = NSAttributedString(properties: properties)
            self.numberOfLines = properties.numberOfLines
            self.lineBreakMode = NSLineBreakMode(lineBreakMode: properties.lineBreakMode)
        case .image, .view:
            break
        }
    }
}
