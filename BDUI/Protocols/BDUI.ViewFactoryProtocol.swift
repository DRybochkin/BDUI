//
//  BDUI.ViewFactoryProtocol.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

extension BDUI {
    
    protocol ViewFactoryProtocol: AnyObject {
        
        // MARK: - Functions
        
        func register<T: ViewLayoutProtocol>(factory: @escaping (Layouter) -> T?)
        func resolve(layouter: Layouter) -> ViewLayoutProtocol?
    }
}
