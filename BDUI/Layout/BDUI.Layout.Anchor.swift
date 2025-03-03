//
//  BDUI.Layout.Anchor.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Layout {
    
    enum Anchor: Equatable {
        
        // MARK: - Properties
        
        case superview(AnchorType)
        case element(elementId: String, type: AnchorType)
    }
}

extension BDUI.Layout.Anchor: Codable {
    
    // MARK: - Initializations
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType {
        case .superview:
            let anchorType = try container.decode(BDUI.Layout.AnchorType.self, forKey: .anchorType)
            self = .superview(anchorType)
        case .element:
            let anchorType = try container.decode(BDUI.Layout.AnchorType.self, forKey: .anchorType)
            let elementId = try container.decode(String.self, forKey: .elementId)
            self = .element(elementId: elementId, type: anchorType)
        }
    }
    
    // MARK: - Functions
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .superview(anchorType):
            try container.encode(ValueType.superview, forKey: .type)
            try container.encode(anchorType, forKey: .anchorType)
        case let .element(elementId, anchorType):
            try container.encode(ValueType.element, forKey: .type)
            try container.encode(elementId, forKey: .elementId)
            try container.encode(anchorType, forKey: .anchorType)
        }
    }
    
    // MARK: - Types
    
    enum ValueType: String, Codable {
        case superview
        case element
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case anchorType
        case elementId
    }
}
