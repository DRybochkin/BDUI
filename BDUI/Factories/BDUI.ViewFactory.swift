//
//  BDUI.ViewFactory.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

extension BDUI {
    
    final class ViewFactory {
        
        // MARK: - Private properties
        
        private var factories: [String: ((Layouter) -> ViewLayoutProtocol?)] = [:]
    }
}

extension BDUI.ViewFactory: BDUI.ViewFactoryProtocol {
    
    // MARK: - ViewFactoryProtocol functions
    
    func register<T: BDUI.ViewLayoutProtocol>(factory: @escaping (BDUI.Layouter) -> T?) {
        factories[T.identifier] = factory
    }
    
    func resolve(layouter: BDUI.Layouter) -> BDUI.ViewLayoutProtocol? {
        let element = layouter.element
        guard let factory = factories[element.elementType] else {
            assert(false, "Factory not exist for elementType:\(element.elementType) elementId: \(element.elementId)")
            return nil
        }
        guard let result = factory(layouter) else {
            assert(false, "Can't resolve view for elementType:\(element.elementType) elementId: \(element.elementId)")
            return nil
        }
        return result
    }
}
