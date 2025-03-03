//
//  BDUI.ViewLayoutProtocol.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

extension BDUI {
    
    protocol ViewLayoutProtocol: UIView {
        
        // MARK: - Properties
        
        static var identifier: String { get }
        var factory: ViewFactoryProtocol { get }

        // MARK: - Initializations
        
        init(layouter: Layouter)
        
        // MARK: - Functions
        
        func calculateFrame()
        func update(layouter: Layouter)
    }
}
