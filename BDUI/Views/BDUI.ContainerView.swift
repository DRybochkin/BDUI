//
//  BDUI.ContainerView.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

extension BDUI {
    
    final class ContainerView: UIView {
        
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

extension BDUI.ContainerView: BDUI.ViewLayoutProtocol {
    
    // MARK: - ViewLayoutProtocol properties
    
    static var identifier: String { _typeName(Self.self, qualified: false) }
    
    // MARK: - Functions
    
    func calculateFrame() {
        frame = layouter.state.frame
        elements.values.forEach { $0.calculateFrame() }
    }
    
    func update(layouter: BDUI.Layouter) {
        self.layouter = layouter
        elements.enumerated().forEach {
            if layouter.subLayouters.indices.contains($0.offset) {
                let layouter = layouter.subLayouters[$0.offset]
                $0.element.value.update(layouter: layouter)
            }
        }
        calculateFrame()
    }
}

private extension BDUI.ContainerView {
    
    // MARK: - Private functions
    
    func configure() {
        applyProperties()
        layouter.subLayouters.forEach { item in
            guard let view = factory.resolve(layouter: item) else { return }
            elements[item.element.elementId] = view
            addSubview(view)
        }
    }
    
    func applyProperties() {
        accessibilityLabel = layouter.element.elementId
        switch layouter.element.properties {
        case let .view(properties):
            if let backgroundColor = properties.backgroundColor {
                self.backgroundColor = UIColor(hex: backgroundColor)
            }
            if let cornerRadius = properties.cornerRadius {
                self.layer.cornerRadius = cornerRadius
            }
            self.clipsToBounds = properties.clipToBounds
        case .label, .image:
            break
        }
    }
}
