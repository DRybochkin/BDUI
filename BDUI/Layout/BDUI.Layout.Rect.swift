//
//  BDUI.Layout.Rect.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 01.03.2025.
//

extension BDUI.Layout {
    
    struct Rect: Codable, Equatable {
        
        // MARK: - Properties
        
        static let fill = Rect(x: .relative(.superview(.left())),
                               y: .relative(.superview(.top())),
                               width: .relative(.superview(.width())),
                               height: .relative(.superview(.height())))

        let x: Value
        let y: Value
        let width: Value
        let height: Value
        
        // MARK: - Initializations
        
        init(x: Value = .relative(.superview(.left())),
             y: Value = .relative(.superview(.top())),
             width: Value = .relative(.superview(.width())),
             height: Value = .relative(.superview(.height()))) {
            self.x = x
            self.y = y
            self.width = width
            self.height = height
        }

        init(rect: Self, x: Value? = nil, y: Value? = nil, width: Value? = nil, height: Value? = nil) {
            self.x = x ?? rect.x
            self.y = y ?? rect.y
            self.width = width ?? rect.width
            self.height = height ?? rect.height
        }
    }
}
