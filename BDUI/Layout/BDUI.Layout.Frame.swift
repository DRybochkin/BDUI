//
//  BDUI.Layout.Frame.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Layout {
    
    enum Frame: Equatable {
        
        // MARK: - Cases
        
        case object(padding: Padding = .empty)
        case absolute(frame: CGRect = .zero, padding: Padding = .empty)
        case fixed(rect: Rect = .fill, padding: Padding = .empty)
        case dynamicWidth(rect: Rect = .fill, padding: Padding = .empty)
        case dynamicHeight(rect: Rect = .fill, padding: Padding = .empty)
        case subviewsWidth(rect: Rect = .fill, padding: Padding = .empty)
        case subviewsHeight(rect: Rect = .fill, padding: Padding = .empty)
    }
}

extension BDUI.Layout.Frame: Codable {
    
    // MARK: - Initializations
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(ValueType.self, forKey: .type)
        switch valueType {
        case .object:
            let padding = try container.decodeIfPresent(BDUI.Layout.Padding.self, forKey: .padding) ?? .empty
            self = .object(padding: padding)
        case .absolute:
            let padding = try container.decodeIfPresent(BDUI.Layout.Padding.self, forKey: .padding) ?? .empty
            let frame = try container.decodeIfPresent(CGRect.self, forKey: .frame) ?? .zero
            self = .absolute(frame: frame, padding: padding)
        case .fixed:
            let padding = try container.decodeIfPresent(BDUI.Layout.Padding.self, forKey: .padding) ?? .empty
            let rect = try container.decodeIfPresent(BDUI.Layout.Rect.self, forKey: .rect) ?? .fill
            self = .fixed(rect: rect, padding: padding)
        case .dynamicWidth:
            let padding = try container.decodeIfPresent(BDUI.Layout.Padding.self, forKey: .padding) ?? .empty
            let rect = try container.decodeIfPresent(BDUI.Layout.Rect.self, forKey: .rect) ?? .fill
            self = .dynamicWidth(rect: rect, padding: padding)
        case .dynamicHeight:
            let padding = try container.decodeIfPresent(BDUI.Layout.Padding.self, forKey: .padding) ?? .empty
            let rect = try container.decodeIfPresent(BDUI.Layout.Rect.self, forKey: .rect) ?? .fill
            self = .dynamicHeight(rect: rect, padding: padding)
        case .subviewsWidth:
            let padding = try container.decodeIfPresent(BDUI.Layout.Padding.self, forKey: .padding) ?? .empty
            let rect = try container.decodeIfPresent(BDUI.Layout.Rect.self, forKey: .rect) ?? .fill
            self = .subviewsWidth(rect: rect, padding: padding)
        case .subviewsHeight:
            let padding = try container.decodeIfPresent(BDUI.Layout.Padding.self, forKey: .padding) ?? .empty
            let rect = try container.decodeIfPresent(BDUI.Layout.Rect.self, forKey: .rect) ?? .fill
            self = .subviewsHeight(rect: rect, padding: padding)
        }
    }
    
    // MARK: - Functions
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .object(padding):
            try container.encode(ValueType.object, forKey: .type)
            try container.encode(padding, forKey: .padding)
        case let .absolute(frame, padding):
            try container.encode(ValueType.absolute, forKey: .type)
            try container.encode(frame, forKey: .frame)
            try container.encode(padding, forKey: .padding)
        case let .fixed(rect, padding):
            try container.encode(ValueType.fixed, forKey: .type)
            try container.encode(rect, forKey: .rect)
            try container.encode(padding, forKey: .padding)
        case .dynamicWidth(rect: let rect, padding: let padding):
            try container.encode(ValueType.dynamicWidth, forKey: .type)
            try container.encode(rect, forKey: .rect)
            try container.encode(padding, forKey: .padding)
        case .dynamicHeight(rect: let rect, padding: let padding):
            try container.encode(ValueType.dynamicHeight, forKey: .type)
            try container.encode(rect, forKey: .rect)
            try container.encode(padding, forKey: .padding)
        case .subviewsWidth(rect: let rect, padding: let padding):
            try container.encode(ValueType.subviewsWidth, forKey: .type)
            try container.encode(rect, forKey: .rect)
            try container.encode(padding, forKey: .padding)
        case .subviewsHeight(rect: let rect, padding: let padding):
            try container.encode(ValueType.subviewsHeight, forKey: .type)
            try container.encode(rect, forKey: .rect)
            try container.encode(padding, forKey: .padding)
        }
    }
    
    // MARK: - Types
    
    enum ValueType: String, Codable {
        case object
        case absolute
        case fixed
        case dynamicWidth
        case dynamicHeight
        case subviewsWidth
        case subviewsHeight
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case padding
        case frame
        case rect
    }
}
