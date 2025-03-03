//
//  DBUI.Layouter.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 27.02.2025.
//

import Foundation

extension BDUI {
    
    final class Layouter {
        
        // MARK: - Properties
        
        private let element: BDUI.Element
        private(set) var outerRealtions: [BDUI.Element] = []
        private(set) var innerRealtions: [BDUI.Element] = []
        private(set) var realtions: [BDUI.Element] = []
        
        // MARK: - Initializations
        
        init(element: BDUI.Element) {
            self.element = element
        }
    }
}

private extension BDUI.Layouter {

    // MARK: - Private functions
    
    func calculateRelations() {
        elements.forEach {
            let relations = getRelations(element: $0)
            relationElements.append(contentsOf: relations)
        }
        relationElements.forEach { $0.calculateRelations() }
    }
    
    func getElement(by elementId: String?) -> BDUI.Element? {
        elements.first { $0.elementId == elementId }
    }
    
    func getRelations(element: BDUI.Element) -> [BDUI.Element] {
        switch element.layout.frame {
        case .absolute:
            []
        case let .fixed(x, y, width, height):
            [x, y, width, height].compactMap { getElement(by: relationId(value: $0)) }
        case .dynamicWidth, .dynamicHeight:
            elements
        }
    }
    
    func relationId(value: BDUI.Layout.Value) -> String? {
        switch value {
        case .absolute:
            nil
        case let .relative(anсhor):
            switch anсhor {
            case .superview:
                switch layout.frame {
                case .absolute:
                    nil
                case let .fixed(x, y, width, height):
                    [x, y, width, height].compactMap { getElement(by: relationId(value: $0)) }
                case .dynamicWidth, .dynamicHeight:
                    elements
                }
                // TODO нужно проверить что родитель не имеет динамическую высоту
            case let .element(elementId, _):
                elementId
            }
        }
    }
}
