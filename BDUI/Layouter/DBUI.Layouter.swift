//
//  DBUI.Layouter.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 27.02.2025.
//

import UIKit

struct StoredState: Equatable {
    let frame: CGRect
    let frameWithPadding: CGRect
    let insets: BDUI.Layout.EdgeInsets
    
    init(frame: CGRect, frameWithPadding: CGRect, insets: BDUI.Layout.EdgeInsets) {
        self.frame = frame
        self.frameWithPadding = frameWithPadding
        self.insets = insets
    }
    
    init(state: StoredState, frame: CGRect? = nil, frameWithPadding: CGRect? = nil, insets: BDUI.Layout.EdgeInsets? = nil) {
        self.frame = frame ?? state.frame
        self.frameWithPadding = frameWithPadding ?? state.frameWithPadding
        self.insets = insets ?? state.insets
    }
}

extension BDUI {
    
    final class Layouter {
        
        // MARK: - Properties
        
        let element: BDUI.Element
        let parent: BDUI.Layouter?
        private(set) var subLayouters: [Layouter] = []
        private(set) var state = StoredState(frame: .greatestFiniteMagnitude,
                                             frameWithPadding: .greatestFiniteMagnitude,
                                             insets: .zero)
        private(set) var states: [CGRect: StoredState] = [:]

        // MARK: - Initializations
        
        init(element: BDUI.Element, parent: BDUI.Layouter?) {
            self.element = element
            self.parent = parent
            self.subLayouters = element.elements.compactMap { Layouter(element: $0, parent: self) }
        }
        
        // MARK: - Functions
        
        @discardableResult
        func calculate(parentFrame: CGRect) -> CGRect {
            if let storedState = states[parentFrame], storedState.frame.isCalculated {
                state = storedState
                calculateSubLayouters()
                return storedState.frame
            }
            
            switch element.layout.frame {
            case let .absolute(rect, padding):
                calculateAbsolute(parentFrame: rect == .zero ? parentFrame : rect, padding: padding)
            case let .fixed(rect, padding):
                calculateFixed(parentFrame: parentFrame, rect: rect, padding: padding)
            case let .dynamicHeight(rect, padding):
                calculateDynamicHeight(parentFrame: parentFrame, rect: rect, padding: padding)
            case let .dynamicWidth(rect, padding):
                calculateDynamicWidth(parentFrame: parentFrame, rect: rect, padding: padding)
            case let .object(padding):
                calculateObject(parentFrame: parentFrame, padding: padding)
            case let .subviewsWidth(rect, padding):
                calculateSubviewsWidth(parentFrame: parentFrame, rect: rect, padding: padding)
            case let .subviewsHeight(rect, padding):
                calculateSubviewsHeight(parentFrame: parentFrame, rect: rect, padding: padding)
            }

            if parentFrame.isCalculated {
                states[parentFrame] = state
            }

            let frames = calculateSubLayouters()
            let isChildsCalculated = frames.allSatisfy { $0.isCalculated }
            
            // TODO: - drybochkin нужно построить дерево обхода и считать только 1 раз
            let maximumAttempt = 2
            var attempt = 0
            while !isChildsCalculated, attempt < maximumAttempt {
                calculate(parentFrame: parentFrame)
                attempt += 1
            }
            
            return state.frame
        }
        
        func update(frame: CGRect) -> Bool {
            switch element.layout.frame {
            case .object, .fixed, .dynamicWidth, .dynamicHeight, .subviewsWidth, .subviewsHeight:
                return false
            case let .absolute(currentFrame, padding):
                // TODO: - drybochkin нужно кешировать фреймы для разных размеров 
                guard currentFrame != frame else { return false }
                let layout = BDUI.Layout(frame: .absolute(frame: frame, padding: padding))
                guard element.layout != layout else { return false }
                element.update(layout: layout)
                reset()
                calculate(parentFrame: frame)
                return true
            }
        }
    }
}

private extension BDUI.Layouter {

    // MARK: - Private functions
    
    func reset() {
        state = StoredState(frame: .greatestFiniteMagnitude,
                            frameWithPadding: .greatestFiniteMagnitude,
                            insets: .zero)
        subLayouters.forEach { $0.reset() }
    }
    
    func calculate(rect: BDUI.Layout.Rect) -> CGRect {
        let x = calculate(value: rect.x)
        let y = calculate(value: rect.y)
        let width = calculate(value: rect.width)
        let height = calculate(value: rect.height)
        return CGRect(x: x, y: y, width: width, height: height)
    }

    func calculate(padding: BDUI.Layout.Padding) -> BDUI.Layout.EdgeInsets {
        let top = calculate(value: padding.top)
        let right = calculate(value: padding.right)
        let bottom = calculate(value: padding.bottom)
        let left = calculate(value: padding.left)
        return BDUI.Layout.EdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func decrease(frame: CGRect, padding: BDUI.Layout.Padding) -> CGRect {
        let top = calculate(value: padding.top)
        let left = calculate(value: padding.left)
        let bottom = calculate(value: padding.bottom)
        let right = calculate(value: padding.right)
        let width = frame.widthCalculated && left < .greatestFiniteMagnitude && right < .greatestFiniteMagnitude ? frame.width - left - right : .greatestFiniteMagnitude
        let height = frame.heightCalculated && top < .greatestFiniteMagnitude && bottom < .greatestFiniteMagnitude ? frame.height - top - bottom : .greatestFiniteMagnitude
        return CGRect(x: .zero, y: .zero, width: width, height: height)
    }

    func calculate(frames: [CGRect]) -> CGRect {
        let frames = frames.compactMap {
            CGRect(x: $0.xCalculated ? $0.minX : .zero,
                   y: $0.yCalculated ? $0.minY : .zero,
                   width: $0.widthCalculated ? $0.width : .zero,
                   height: $0.heightCalculated ? $0.height : .zero)
        }
        let minX = frames.min(by: { $0.minX < $1.minX })?.minX ?? .zero
        let minY = frames.min(by: { $0.minY < $1.minY })?.minY ?? .zero
        let maxX = frames.min(by: { $0.maxX > $1.maxX })?.maxX ?? .zero
        let maxY = frames.min(by: { $0.maxY > $1.maxY })?.maxY ?? .zero
        return CGRect(x: minX, y: minY, width: maxX, height: maxY)
    }
    
    func calculate(properties: BDUI.Element.Properties, width: CGFloat) -> CGFloat {
        switch properties {
        case let .label(properties):
            guard width > 0 else { return .zero }
            //  TODO: - drybochkin подумать как сделать универсально
            return NSAttributedString(properties: properties)
                .heightFor(width: width, numberOfLines: properties.numberOfLines)
        case .image, .view:
            return .zero
        }
    }

    func calculate(properties: BDUI.Element.Properties, height: CGFloat) -> CGFloat {
        switch properties {
        case let .label(properties):
            //  TODO: - drybochkin подумать как сделать универсально
            return NSAttributedString(properties: properties)
                .widthFor(height: height, numberOfLines: properties.numberOfLines)
        case .image, .view:
            return .zero
        }
    }

    func calculate(value: BDUI.Layout.Value) -> CGFloat {
        switch value {
        case let .absolute(value):
            value
        case let .relative(anchor):
            calculate(anchor: anchor)
        case .empty:
            .zero
        }
    }
    
    func subLayouter(elementId: String) -> BDUI.Layouter? {
        subLayouters.first { $0.element.elementId == elementId }
    }

    @discardableResult
    func calculateSubLayouters() -> [CGRect] {
        // TODO: - drybochkin построить дерево зависимостией и обходить по нему
        subLayouters.compactMap { $0.calculate(parentFrame: state.frame) }
    }

    func calculate(anchor: BDUI.Layout.Anchor) -> CGFloat {
        switch anchor {
        case let .element(elementId, anchorType):
            guard let anchorLayouter = parent?.subLayouter(elementId: elementId) else {
                assert(false, "anchor with id = \(elementId) not found")
                return .zero
            }
            return calculate(anchorType: anchorType, anchorFrame: anchorLayouter.state.frame)
        case let .superview(anchorType):
            return calculate(anchorType: anchorType, anchorFrame: state.frameWithPadding)
        }
    }

    func calculate(anchorValue: BDUI.Layout.AnchorValue, value: CGFloat) -> CGFloat {
        switch anchorValue {
        case let .offset(offset):
            value + offset
        case let .multiply(multiply, offset):
            (value * multiply + offset).rounded(.up)
        case .empty:
            value
        }
    }

    func calculate(anchorType: BDUI.Layout.AnchorType, anchorFrame: CGRect) -> CGFloat {
        switch anchorType {
        case let .top(value):
            anchorFrame.yCalculated ? calculate(anchorValue: value, value: anchorFrame.minY) : .greatestFiniteMagnitude
        case let .left(value):
            anchorFrame.xCalculated ? calculate(anchorValue: value, value: anchorFrame.minX) : .greatestFiniteMagnitude
        case let .bottom(value):
            anchorFrame.heightCalculated && anchorFrame.heightCalculated ? calculate(anchorValue: value, value: anchorFrame.maxY) : .greatestFiniteMagnitude
        case let .right(value):
            anchorFrame.xCalculated && anchorFrame.widthCalculated ? calculate(anchorValue: value, value: anchorFrame.maxX) : .greatestFiniteMagnitude
        case let .centerX(value):
            anchorFrame.widthCalculated && anchorFrame.widthCalculated ? calculate(anchorValue: value, value: anchorFrame.midX) : .greatestFiniteMagnitude
        case let .centerY(value):
            anchorFrame.heightCalculated && anchorFrame.heightCalculated ? calculate(anchorValue: value, value: anchorFrame.midY) : .greatestFiniteMagnitude
        case let .width(value):
            anchorFrame.widthCalculated ? calculate(anchorValue: value, value: anchorFrame.width) : .greatestFiniteMagnitude
        case let .height(value):
            anchorFrame.heightCalculated ? calculate(anchorValue: value, value: anchorFrame.height) : .greatestFiniteMagnitude
        }
    }
    
    func getElement(by elementId: String?) -> BDUI.Layouter? {
        subLayouters.first { $0.element.elementId == elementId }
    }
    
    func calculate(widthAncorType: BDUI.Layout.AnchorType) -> CGFloat {
        switch widthAncorType {
        case .top, .bottom, .left, .width, .centerY, .right, .centerX:
            assert(false, "not support")
            return state.frame.width
        case .height:
            return state.frame.width - state.insets.left - state.insets.right
        }
    }

    func calculate(heightAncorType: BDUI.Layout.AnchorType) -> CGFloat {
        switch heightAncorType {
        case .top, .bottom, .left, .width, .centerY, .right, .centerX:
            assert(false, "not support")
            return state.frame.height
        case .height:
            return state.frame.height - state.insets.top - state.insets.bottom
        }
    }

    func calculate(xAncorType: BDUI.Layout.AnchorType, parentFrame: CGRect) -> CGFloat {
        switch xAncorType {
        case .top, .bottom, .width, .height, .centerY:
            assert(false, "not support")
            return state.frame.origin.x
        case .left:
            return state.frame.origin.x + state.insets.left
        case .right:
            return parentFrame.width - state.frame.width - state.insets.right
        case .centerX:
            return parentFrame.width / 2  - state.frame.width / 2
        }
    }
    
    func calculate(yAncorType: BDUI.Layout.AnchorType, parentFrame: CGRect) -> CGFloat {
        switch yAncorType {
        case .left, .right, .width, .height, .centerX:
            assert(false, "not support")
            return state.frame.origin.y
        case .top:
            return state.frame.origin.y + state.insets.top
        case .bottom:
            return parentFrame.height - state.frame.height - state.insets.bottom
        case .centerY:
            return parentFrame.height / 2  - state.frame.height / 2
        }
    }
    
    func calculateAbsolute(parentFrame: CGRect, padding: BDUI.Layout.Padding) {
        let parentFrameWithPadding = parentFrame
        let insets = calculate(padding: padding)
        let currentFrame = CGRect(x: parentFrame.origin.x + insets.left,
                                  y: parentFrame.origin.y + insets.top,
                                  width: parentFrame.width - insets.left - insets.right,
                                  height: parentFrame.height - insets.top - insets.bottom)
        state = StoredState(frame: currentFrame, frameWithPadding: parentFrameWithPadding, insets: insets)
    }
    
    func calculateFixed(parentFrame: CGRect, rect: BDUI.Layout.Rect, padding: BDUI.Layout.Padding) {
        state = StoredState(state: state, frameWithPadding: decrease(frame: parentFrame, padding: padding))
        state = StoredState(state: state, insets: calculate(padding: padding))
        state = StoredState(state: state, frame: calculate(rect: rect))
        let currentFrame = CGRect(x: calculate(xAncorType: rect.x.anchorType, parentFrame: parentFrame),
                                  y: calculate(yAncorType: rect.y.anchorType, parentFrame: parentFrame),
                                  width: state.frame.width,
                                  height: state.frame.height)
        state = StoredState(state: state, frame: currentFrame)
    }
    
    func calculateDynamicHeight(parentFrame: CGRect, rect: BDUI.Layout.Rect, padding: BDUI.Layout.Padding) {
        state = StoredState(state: state, frameWithPadding: decrease(frame: parentFrame, padding: padding))
        let width = calculate(value: rect.width)
        let height = min(calculate(properties: element.properties, width: width), state.frameWithPadding.height)
        let rect = BDUI.Layout.Rect(rect: rect, height: .absolute(height))
        state = StoredState(state: state, insets: calculate(padding: padding))
        state = StoredState(state: state, frame: calculate(rect: rect))
        var currentFrame = CGRect(x: calculate(xAncorType: rect.x.anchorType, parentFrame: parentFrame),
                                  y: calculate(yAncorType: rect.y.anchorType, parentFrame: parentFrame),
                                  width: state.frame.width,
                                  height: state.frame.height)
        if parentFrame.height < currentFrame.maxY {
            currentFrame = CGRect(x: currentFrame.origin.x,
                                  y: currentFrame.origin.y,
                                  width: currentFrame.width,
                                  height: currentFrame.height - currentFrame.maxY + parentFrame.height - state.insets.bottom)
        }
        state = StoredState(state: state, frame: currentFrame)
    }
    
    func calculateDynamicWidth(parentFrame: CGRect, rect: BDUI.Layout.Rect, padding: BDUI.Layout.Padding) {
        state = StoredState(state: state, frameWithPadding: decrease(frame: parentFrame, padding: padding))
        let height = calculate(value: rect.height)
        let width = min(calculate(properties: element.properties, height: height), state.frameWithPadding.width)
        let rect = BDUI.Layout.Rect(rect: rect, width: .absolute(width))
        state = StoredState(state: state, insets: calculate(padding: padding))
        state = StoredState(state: state, frame: calculate(rect: rect))
        var currentFrame = CGRect(x: calculate(xAncorType: rect.x.anchorType, parentFrame: parentFrame),
                                  y: calculate(yAncorType: rect.y.anchorType, parentFrame: parentFrame),
                                  width: state.frame.width,
                                  height: state.frame.height)
        if parentFrame.width < currentFrame.maxX {
            currentFrame = CGRect(x: currentFrame.origin.x,
                                  y: currentFrame.origin.y,
                                  width: currentFrame.width - currentFrame.maxX + parentFrame.width - state.insets.right,
                                  height: currentFrame.height)
        }
        state = StoredState(state: state, frame: currentFrame)
    }
    
    func calculateObject(parentFrame: CGRect, padding: BDUI.Layout.Padding) {
        // TODO: - drybochkin добавить возмоность описывать размеры в самом объекте, возможно потребуетя для виджетов
        let parentFrameWithPadding = decrease(frame: parentFrame, padding: padding)
        state = StoredState(frame: parentFrameWithPadding,
                            frameWithPadding: parentFrameWithPadding,
                            insets: calculate(padding: padding))
    }
    
    func calculateSubviewsHeight(parentFrame: CGRect, rect: BDUI.Layout.Rect, padding: BDUI.Layout.Padding) {
        // TODO: - drybochkin добавить проверку, что нет детей с относительно засисимостью высоты от супервью
        state = StoredState(state: state, frame: calculate(rect: rect))
        var parentFrameWithPadding = decrease(frame: parentFrame, padding: padding)
        state = StoredState(state: state, frameWithPadding: parentFrameWithPadding)
        parentFrameWithPadding.size.height = calculate(rect: rect).height
        state = StoredState(state: state, frameWithPadding: parentFrameWithPadding)
        state = StoredState(state: state, insets: calculate(padding: padding))
        var currentFrame = state.frame
        currentFrame.size.width = calculate(value: rect.width) - state.insets.left - state.insets.right
        state = StoredState(state: state, frame: currentFrame)
        let frames = calculateSubLayouters()
        let calculatedFrame = calculate(frames: frames)
        if calculatedFrame.height > state.frameWithPadding.height {
            // TODO: - drybochkin recalculate subitems
        }
        print(">>>>>>", element.elementId, calculatedFrame, state.frameWithPadding.height, parentFrameWithPadding.height)
        let height = min(calculatedFrame.height, state.frameWithPadding.height, parentFrameWithPadding.height)
        let rect = BDUI.Layout.Rect(rect: rect, height: .absolute(height))
        state = StoredState(state: state, frame: calculate(rect: rect))
        currentFrame = CGRect(x: calculate(xAncorType: rect.x.anchorType, parentFrame: parentFrame),
                              y: calculate(yAncorType: rect.y.anchorType, parentFrame: parentFrame),
                              width: state.frame.width,
                              height: state.frame.height)
        state = StoredState(state: state, frame: currentFrame)
    }
    
    func calculateSubviewsWidth(parentFrame: CGRect, rect: BDUI.Layout.Rect, padding: BDUI.Layout.Padding) {
        // TODO: - drybochkin добавить проверку, что нет детей с относительно засисимостью ширины от супервью
        var parentFrameWithPadding = decrease(frame: parentFrame, padding: padding)
        state = StoredState(state: state, frameWithPadding: parentFrameWithPadding)
        parentFrameWithPadding.size.width = calculate(rect: rect).width
        state = StoredState(state: state, frameWithPadding: parentFrameWithPadding)
        state = StoredState(state: state, insets: calculate(padding: padding))
        var currentFrame = state.frame
        currentFrame.size.height = calculate(value: rect.height) - state.insets.top - state.insets.bottom
        state = StoredState(state: state, frame: currentFrame)
        let frames = calculateSubLayouters()
        let calculatedFrame = calculate(frames: frames)
        let width = min(calculatedFrame.width, parentFrameWithPadding.width)
        let rect = BDUI.Layout.Rect(rect: rect, width: .absolute(width))
        state = StoredState(state: state, frame: calculate(rect: rect))
        currentFrame = CGRect(x: calculate(xAncorType: rect.x.anchorType, parentFrame: parentFrame),
                              y: calculate(yAncorType: rect.y.anchorType, parentFrame: parentFrame),
                              width: state.frame.width,
                              height: state.frame.height)
        state = StoredState(state: state, frame: currentFrame)
    }
}
