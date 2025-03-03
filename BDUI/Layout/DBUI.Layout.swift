//
//  DBUI.Layout.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI {
    
    final class Layout {
        
        // MARK: - Properties
        
        let frame: Frame
        
        // MARK: - Initializations
        
        init(frame: Frame) {
            self.frame = frame
        }
    }
}

extension BDUI.Layout: Codable {
    
    // MARK: - Codable initializations
    
    convenience init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let frame = try container.decode(BDUI.Layout.Frame.self, forKey: CodingKeys.frame)
        self.init(frame: frame)
    }
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case frame
    }
}

extension BDUI.Layout: Equatable {
    
    // MARK: - Equatable functions
    
    static func == (lhs: BDUI.Layout, rhs: BDUI.Layout) -> Bool {
        lhs.frame == rhs.frame
    }
}
 
