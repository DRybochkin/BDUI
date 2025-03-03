//
//  BDUI.Value.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI {

    enum Value: Decodable {

        // MARK: - Cases

        case absolute(CGFloat)
        case relative(Anchor)
    }
}
