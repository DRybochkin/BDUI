//
//  BDUI.Layout.AnchorValue.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Layout {
    
    enum AnchorValue: Equatable {
        
        // MARK: - Cases
        
        case empty
        case offset(CGFloat)
        case multiply(CGFloat, offset: CGFloat = .zero)
    }
}

extension BDUI.Layout.AnchorValue: Codable {
    
    // MARK: - Initializations
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType {
        case .empty:
            self = .empty
        case .offset:
            let value = try container.decodeIfPresent(CGFloat.self, forKey: .value) ?? .zero
            self = .offset(value)
        case .multiply:
            let value = try container.decodeIfPresent(CGFloat.self, forKey: .value) ?? 1
            let offset = try container.decodeIfPresent(CGFloat.self, forKey: .offset) ?? .zero
            self = .multiply(value, offset: offset)
        }
    }
    
    // MARK: - Functions
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .empty:
            try container.encode(ValueType.empty, forKey: .type)
        case let .offset(value):
            try container.encode(ValueType.offset, forKey: .type)
            try container.encode(value, forKey: .value)
        case let .multiply(value, offset):
            try container.encode(ValueType.multiply, forKey: .type)
            try container.encode(value, forKey: .value)
            try container.encode(offset, forKey: .offset)
        }
    }
    
    // MARK: - Types
    
    enum ValueType: String, Codable {
        case empty
        case offset
        case multiply
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case offset
        case value
    }
}
