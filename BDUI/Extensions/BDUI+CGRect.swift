//
//  BDUI+CGRect.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 02.03.2025.
//

import Foundation

extension CGRect {
    
    // MARK: - Properties
    
    static let greatestFiniteMagnitude = CGRect(x: CGFloat.greatestFiniteMagnitude,
                                                y: CGFloat.greatestFiniteMagnitude,
                                                width: CGFloat.greatestFiniteMagnitude,
                                                height: CGFloat.greatestFiniteMagnitude)
    
    var isCalculated: Bool { xCalculated && yCalculated && widthCalculated && heightCalculated }
    var xCalculated: Bool { origin.x < CGFloat.greatestFiniteMagnitude }
    var yCalculated: Bool { origin.y < CGFloat.greatestFiniteMagnitude }
    var widthCalculated: Bool { width < CGFloat.greatestFiniteMagnitude }
    var heightCalculated: Bool { height < CGFloat.greatestFiniteMagnitude }
}
