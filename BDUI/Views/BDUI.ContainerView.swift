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
        
        private let layouter: Layouter
        private var elements: [String: ViewLayoutProtocol] = [:]

        // MARK: - Initializations
        
        required init(layouter: Layouter) {
            self.layouter = layouter
            super.init(frame: .zero)
            
            configure()
            applyProperties()
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
        frame = layouter.frame()
        elements.values.forEach { $0.calculateFrame() }
    }
    
    func applyProperties() {
        guard let properties = layouter.element.properties else { return }
        if let backgroundColor = properties.backgroundColor {
            self.backgroundColor = UIColor(hex: backgroundColor)
        }
        if let cornerRadius = properties.cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

private extension BDUI.ContainerView {
    
    // MARK: - Private functions
    
    func configure() {
        layouter.subLayouters.forEach { item in
            guard let view = factory.resolve(layouter: item) else { return }
            elements[item.element.elementId] = view
            addSubview(view)
        }
    }
}

private extension UIColor {
    
    // MARK: - UIColor initializations
    
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
