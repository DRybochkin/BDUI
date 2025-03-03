//
//  BDUI+NSAttributedString.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import UIKit

extension NSAttributedString {

    // MARK: - Initializations
    
    convenience init(properties: BDUI.Element.Properties.Label) {
        self.init(string: properties.text ?? "",
                  font: properties.font,
                  color: properties.color,
                  alignment: properties.textAligment,
                  lineBreakMode: properties.lineBreakMode)
    }
    
    convenience init(string: String,
                     font: BDUI.Font,
                     color: String?,
                     backgroundColor: String? = nil,
                     alignment: BDUI.TextAlignment = .natural,
                     lineBreakMode: BDUI.LineBreakMode = .byWordWrapping) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = 1
        paragraph.alignment = NSTextAlignment(textAlignment: alignment)
        paragraph.lineBreakMode = NSLineBreakMode(lineBreakMode: .byWordWrapping)

        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.build(font: font),
            .paragraphStyle: paragraph,
            .baselineOffset: 0,
            .tracking: 0,
        ]
        if let color, let color = UIColor(hex: color) {
            attributes[.foregroundColor] = color
        }
        if let backgroundColor, let backgroundColor = UIColor(hex: backgroundColor) {
            attributes[.backgroundColor] = backgroundColor
        }
        self.init(string: string, attributes: attributes)
    }

    // MARK: - Functions
    
    func heightFor(width: CGFloat, numberOfLines: Int) -> CGFloat {
        let maxSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let textContainer = NSTextContainer(size: maxSize)
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineFragmentPadding = 0
        let textStorage = NSTextStorage(attributedString: self)
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        return layoutManager.usedRect(for: textContainer).size.height.rounded(.up)
    }

    func widthFor(height: CGFloat, numberOfLines: Int) -> CGFloat {
        let maxSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        let textContainer = NSTextContainer(size: maxSize)
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineFragmentPadding = 0
        let textStorage = NSTextStorage(attributedString: self)
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        return layoutManager.usedRect(for: textContainer).size.width.rounded(.up)
    }
}
