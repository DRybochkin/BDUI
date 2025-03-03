//
//  DBUI.Layout.AnchorType.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Layout {
    
    enum AnchorType: Equatable {
        
        // MARK: - Cases
        
        case top(AnchorValue = .empty)
        case left(AnchorValue = .empty)
        case bottom(AnchorValue = .empty)
        case right(AnchorValue = .empty)
        case centerX(AnchorValue = .empty)
        case centerY(AnchorValue = .empty)
        case width(AnchorValue = .empty)
        case height(AnchorValue = .empty)
    }
}

extension BDUI.Layout.AnchorType: Codable {
    
    // MARK: - Initializations
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        let anchorValue = try container.decodeIfPresent(BDUI.Layout.AnchorValue.self, forKey: .anchorValue) ?? .empty
        switch valueType {
        case .top:
            self = .top(anchorValue)
        case .left:
            self = .left(anchorValue)
        case .bottom:
            self = .bottom(anchorValue)
        case .right:
            self = .right(anchorValue)
        case .centerX:
            self = .centerX(anchorValue)
        case .centerY:
            self = .centerY(anchorValue)
        case .width:
            self = .width(anchorValue)
        case .height:
            self = .height(anchorValue)
        }
    }
    
    // MARK: - Functions
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
            
        case let .top(anchorValue):
            try container.encode(ValueType.top, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        case let .left(anchorValue):
            try container.encode(ValueType.left, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        case let .bottom(anchorValue):
            try container.encode(ValueType.bottom, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        case let .right(anchorValue):
            try container.encode(ValueType.right, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        case let .centerX(anchorValue):
            try container.encode(ValueType.centerX, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        case let .centerY(anchorValue):
            try container.encode(ValueType.centerY, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        case let .width(anchorValue):
            try container.encode(ValueType.width, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        case let .height(anchorValue):
            try container.encode(ValueType.height, forKey: .type)
            try container.encode(anchorValue, forKey: .anchorValue)
        }
    }
    
    // MARK: - Types
    
    enum ValueType: String, Codable {
        case top
        case left
        case bottom
        case right
        case centerX
        case centerY
        case width
        case height
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case anchorValue
    }
}
