//
//  BDUI.Element.Properties.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI.Element {
        
    enum Properties: Equatable {
        
        // MARK: - Cases
        
        case view(View)
        case label(Label)
        case image(Image)
    }
}

extension BDUI.Element.Properties: Codable {
    
    // MARK: - Initializations
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType {
        case .view:
            let view = try container.decode(View.self, forKey: .value)
            self = .view(view)
        case .label:
            let view = try container.decode(Label.self, forKey: .value)
            self = .label(view)
        case .image:
            let view = try container.decode(Image.self, forKey: .value)
            self = .image(view)
        }
    }
    
    // MARK: - Functions
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .view(view):
            try container.encode(ValueType.view, forKey: .type)
            try container.encode(view, forKey: .value)
        case let .label(view):
            try container.encode(ValueType.label, forKey: .type)
            try container.encode(view, forKey: .value)
        case let .image(view):
            try container.encode(ValueType.image, forKey: .type)
            try container.encode(view, forKey: .value)
        }
    }
    
    // MARK: - Types
    
    enum ValueType: String, Codable {
        case view
        case label
        case image
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case value
    }
}
