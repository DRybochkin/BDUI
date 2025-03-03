//
//  DBUI.Element.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

extension BDUI {
    
    final class Element {
        
        // MARK: - Propertis
        
        let elementId: String
        let elementType: String
        let properties: Properties
        private(set) var layout: Layout
        private(set) var elements: [BDUI.Element]
        private(set) var parent: BDUI.Element?
        
        // MARK: - Initializations
        
        init(frame: CGRect, identifier: String, properties: Properties, padding: BDUI.Layout.Padding = .empty) {
            self.elementId = UUID().uuidString
            self.elementType = identifier
            self.layout = Layout(frame: .absolute(frame: frame, padding: padding))
            self.elements = []
            self.parent = nil
            self.properties = properties
        }
        
        init(elementId: String, elementType: String, layout: Layout, properties: Properties, elements: [BDUI.Element] = []) {
            self.elementId = elementId
            self.elementType = elementType
            self.layout = layout
            self.elements = elements
            self.properties = properties
        }
        
        // MARK: - Functions
        
        func add(element: Element) {
            element.parent = self
            elements.append(element)
        }

        func update(layout: Layout) {
            guard self.layout != layout else { return }
            self.layout = layout
        }
    }
}

extension BDUI.Element: Codable {
    
    // MARK: - Codable initializations
    
    convenience init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let elementId = try container.decode(String.self, forKey: CodingKeys.elementId)
        let elementType = try container.decode(String.self, forKey: CodingKeys.elementType)
        let layout = try container.decode(BDUI.Layout.self, forKey: CodingKeys.layout)
        let elements = try container.decode([BDUI.Element].self, forKey: CodingKeys.elements)
        let properties = try container.decode(BDUI.Element.Properties.self, forKey: CodingKeys.properties)
        self.init(elementId: elementId, elementType: elementType, layout: layout, properties: properties, elements: elements)
    }
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case elementId
        case elementType
        case layout
        case elements
        case properties
    }
}
