//
//  BDUI.Frame.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import Foundation

extension BDUI.Layout {
    
    struct Frame: Decodable {
        
        // MARK: - Properties
        
        let x: Value
        let y: Value
        let width: Value
        let height: Value
    }
}
