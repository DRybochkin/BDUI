//
//  BDUI.Font.Family.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 28.02.2025.
//

import Foundation

extension BDUI.Font {
    
    enum Family: Equatable {
        
        // MARK: - Cases
        
        case sans(fontName: String, size: CGFloat, weight: Weight)
        case system(size: CGFloat, weight: Weight)
    }
}

extension BDUI.Font.Family: Codable {
    
    // MARK: - Initializations
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType {
        case .sans:
            let name = try container.decode(String.self, forKey: .name)
            let size = try container.decode(CGFloat.self, forKey: .size)
            let weight = try container.decode(BDUI.Font.Weight.self, forKey: .weight)
            self = .sans(fontName: name, size: size, weight: weight)
        case .system:
            let size = try container.decode(CGFloat.self, forKey: .size)
            let weight = try container.decode(BDUI.Font.Weight.self, forKey: .weight)
            self = .system(size: size, weight: weight)
        }
    }
    
    // MARK: - Functions
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .sans(name, size, weight):
            try container.encode(ValueType.sans, forKey: .type)
            try container.encode(name, forKey: .name)
            try container.encode(size, forKey: .size)
            try container.encode(weight, forKey: .weight)
        case let .system(size, weight):
            try container.encode(ValueType.system, forKey: .type)
            try container.encode(size, forKey: .size)
            try container.encode(weight, forKey: .weight)
        }
    }
    
    // MARK: - Types
    
    enum ValueType: String, Codable {
        case sans
        case system
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case name
        case size
        case weight
    }
}
