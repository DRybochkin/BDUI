//
//  BDUI.ImageView.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

extension BDUI {
    
    final class ImageView: UIImageView {
        
        // MARK: - Private properties
        
        private var layouter: Layouter
        private var elements: [String: ViewLayoutProtocol] = [:]

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

extension BDUI.ImageView: BDUI.ViewLayoutProtocol {

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

private extension BDUI.ImageView {
    
    // MARK: - Private functions
    
    func configure() {
        applyProperties()
    }
    
    func applyProperties() {
        switch layouter.element.properties {
        case let .image(properties):
            if let backgroundColor = properties.backgroundColor {
                self.backgroundColor = UIColor(hex: backgroundColor)
            }
            if let cornerRadius = properties.cornerRadius {
                self.layer.cornerRadius = cornerRadius
            }
            if let image = properties.image {
                self.image = UIImage(named: image)
            }
            self.clipsToBounds = properties.clipToBounds
        case .label, .view:
            break
        }
    }
}
