//
//  BDUI.Layout.Value.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Layout {

    enum Value: Equatable {

        // MARK: - Cases

        case empty
        case absolute(CGFloat)
        case relative(Anchor)
        
        // MARK: - Properties

        var isAbsolute: Bool {
            switch self {
            case .absolute, .empty:
                true
            case .relative:
                false
            }
        }
        
        var anchorType: AnchorType {
            switch self {
            case .absolute, .empty:
                .top()
            case let .relative(anchor):
                switch anchor {
                case .element:
                    .top()
                case let .superview(anchorType):
                    anchorType
                }
            }
        }
    }
}

extension BDUI.Layout.Value: Codable {
    
    // MARK: - Initializations
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType {
        case .empty:
            self = .empty
        case .absolute:
            let value = try container.decodeIfPresent(CGFloat.self, forKey: .value) ?? .zero
            self = .absolute(value)
        case .relative:
            let anchor = try container.decode(BDUI.Layout.Anchor.self, forKey: .anchor)
            self = .relative(anchor)
        }
    }
    
    // MARK: - Functions
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .empty:
            try container.encode(ValueType.empty, forKey: .type)
        case let .absolute(value):
            try container.encode(ValueType.absolute, forKey: .type)
            try container.encode(value, forKey: .value)
        case let .relative(anchor):
            try container.encode(ValueType.relative, forKey: .type)
            try container.encode(anchor, forKey: .anchor)
        }
    }
    
    // MARK: - Types
    
    enum ValueType: String, Codable {
        case empty
        case absolute
        case relative
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case anchor
        case value
    }
}
