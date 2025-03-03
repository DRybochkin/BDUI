//
//  ViewController.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Private properties
    
    private var layouter: BDUI.Layouter?
    private var rootView: BDUI.ViewLayoutProtocol?

    // MARK: - Initializations
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateIfNeeded()
    }
}

private extension ViewController {
    
    // MARK: - Private functions
    
    func configure() {
        let element = load(isManual: true)
        let layouter = BDUI.Layouter(element: element, parent: nil)
        let rootView = factory.resolve(layouter: layouter) ?? BDUI.ContainerView(layouter: layouter)
        self.layouter = layouter
        self.rootView = rootView
        view.backgroundColor = .gray
        view.addSubview(rootView)
        // Проверка предварительного расчета состояний
//        _ = layouter.update(frame: CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.height, height: view.bounds.width))
//        _ = layouter.update(frame: view.bounds)
        layouter.calculate(parentFrame: view.bounds)
        rootView.calculateFrame()
//        encodeElement()
    }
    
    func updateIfNeeded() {
        guard let layouter, let rootView else { return }
        if layouter.update(frame: view.bounds) {
            rootView.calculateFrame()
        } else {
            rootView.frame = layouter.state.frame
        }
    }
    
    func load(isManual: Bool = false) -> BDUI.Element {
        isManual ? createSample1() : loadFromJSON()
    }
    
    func loadFromJSON() -> BDUI.Element {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return createSample1() }
        guard let data = FileManager.default.contents(atPath: path) else { return createSample1() }
        do {
            return try JSONDecoder().decode(BDUI.Element.self, from: data)
        } catch {
            assert(false, "parsing data failure with error \(error)")
            return createSample1()
        }
    }
    
    func createSample1() -> BDUI.Element { // TODO: - drybochkin нужно заменить на парсинг из JSON
        let rootElement = BDUI.Element(frame: UIScreen.main.bounds,
                                       identifier: BDUI.ContainerView.identifier,
                                       properties: .view(BDUI.Element.Properties.View(backgroundColor: "#FFFFFF")),
                                       // TODO: - drybochkin именованные паддинги/офсеты/инсеты
                                       padding: .simple(value: .absolute(50)))

        let backgroundRect = BDUI.Layout.Rect(x: .relative(.superview(.left())),
                                              y: .relative(.superview(.top())),
                                              width: .relative(.superview(.width())),
                                              height: .relative(.superview(.height())))
        let backgroundFrame = BDUI.Layout.Frame.fixed(rect: backgroundRect, padding: .simple(value: .absolute(32)))
        
        let backgroundLayout = BDUI.Layout(frame: backgroundFrame)
        let backgroundElement = BDUI.Element(elementId: "backgroundView",
                                             elementType: _typeName(BDUI.ContainerView.self, qualified: false),
                                             layout: backgroundLayout,
                                             // TODO: - drybochkin подумать как передавать релативные значения cornerRadius
                                             properties: .view(BDUI.Element.Properties.View(backgroundColor: "#00337777", cornerRadius: 32)))
        rootElement.add(element: backgroundElement)
 
        let panelLeftTopRect = BDUI.Layout.Rect(x: .relative(.superview(.left())),
                                                y: .relative(.superview(.top())),
                                                width: .relative(.superview(.width(.multiply(1 / 2, offset: -8)))),
                                                height: .relative(.superview(.height(.multiply(1 / 2, offset: -8)))))
        let panelLeftTopFrame = BDUI.Layout.Frame.fixed(rect: panelLeftTopRect, padding: .simple(value: .absolute(16)))
        
        let panelLeftTopLayout = BDUI.Layout(frame: panelLeftTopFrame)
        let panelLeftTopElement = BDUI.Element(elementId: "TopLeftView",
                                               elementType: _typeName(BDUI.ContainerView.self, qualified: false),
                                               layout: panelLeftTopLayout,
                                               properties: .view(BDUI.Element.Properties.View(backgroundColor: "#11448877", cornerRadius: 16)))
        backgroundElement.add(element: panelLeftTopElement)

        let panelRightTopRect = BDUI.Layout.Rect(x: .relative(.superview(.right())),
                                                 y: .relative(.superview(.top())),
                                                 width: .relative(.superview(.width(.multiply(1 / 2, offset: -8)))),
                                                 height: .relative(.superview(.height(.multiply(1 / 2, offset: -8)))))
        let panelRightTopFrame = BDUI.Layout.Frame.fixed(rect: panelRightTopRect, padding: .simple(value: .absolute(16)))
        
        let panelRightTopLayout = BDUI.Layout(frame: panelRightTopFrame)
        let panelRightTopElement = BDUI.Element(elementId: "RightLeftView",
                                                elementType: _typeName(BDUI.ContainerView.self, qualified: false),
                                                layout: panelRightTopLayout,
                                                properties: .view(BDUI.Element.Properties.View(backgroundColor: "#99226677", cornerRadius: 16)))
        backgroundElement.add(element: panelRightTopElement)

        let panelLeftBottomRect = BDUI.Layout.Rect(x: .relative(.superview(.left())),
                                                   y: .relative(.superview(.bottom())),
                                                   width: .relative(.superview(.width(.multiply(1 / 2, offset: -8)))),
                                                   height: .relative(.superview(.height(.multiply(1 / 2, offset: -8)))))
        let panelLeftBottomFrame = BDUI.Layout.Frame.subviewsHeight(rect: panelLeftBottomRect, padding: .simple(value: .absolute(16)))
        
        let panelLeftBottomLayout = BDUI.Layout(frame: panelLeftBottomFrame)
        let panelLeftBottomElement = BDUI.Element(elementId: "BottomLeftView",
                                                  elementType: _typeName(BDUI.ContainerView.self, qualified: false),
                                                  layout: panelLeftBottomLayout,
                                                  properties: .view(BDUI.Element.Properties.View(backgroundColor: "#33AA7777", cornerRadius: 16)))
        backgroundElement.add(element: panelLeftBottomElement)

        let panelRightBottomRect = BDUI.Layout.Rect(x: .relative(.superview(.right())),
                                                    y: .relative(.element(elementId: "RightLeftView", type: .bottom())),
                                                    width: .relative(.superview(.width(.multiply(1 / 2, offset: -8)))),
                                                    height: .relative(.superview(.height(.multiply(1 / 2, offset: -8)))))
        let panelRightBottomFrame = BDUI.Layout.Frame.subviewsHeight(rect: panelRightBottomRect, padding: .simple(value: .absolute(16)))
        
        let panelRightBottomLayout = BDUI.Layout(frame: panelRightBottomFrame)
        let panelRightBottomElement = BDUI.Element(elementId: "BottomRightView",
                                                   elementType: _typeName(BDUI.ContainerView.self, qualified: false),
                                                   layout: panelRightBottomLayout,
                                                   properties: .view(BDUI.Element.Properties.View(backgroundColor: "#BB448877", cornerRadius: 16)))
        backgroundElement.add(element: panelRightBottomElement)

        let text = "Длинный текст может еще длиннее  fdsfsdfdsfdsf fdsfsdfsdf Длинный текст может еще длиннее авфафааываыва ffdsfsdfsdfds fdsfsdfdsfdsf fdsfsdfsdf"
        let leftTopLabelRect = BDUI.Layout.Rect(x: .relative(.superview(.centerX())),
                                                y: .relative(.superview(.centerY())),
                                                width: .relative(.superview(.width(.multiply(0.2)))))
        let leftTopLabelFrame = BDUI.Layout.Frame.dynamicHeight(rect: leftTopLabelRect, padding: .simple(value: .absolute(16)))
        let leftTopLabelLayout = BDUI.Layout(frame: leftTopLabelFrame)
        let leftTopLabelElement = BDUI.Element(elementId: "LeftTopLabel",
                                               elementType: _typeName(BDUI.Label.self, qualified: false),
                                               layout: leftTopLabelLayout,
                                               properties: .label(BDUI.Element.Properties.Label(text: text, numberOfLines: 0, backgroundColor: "#9933AA77", color: "#000000", lineBreakMode: .byTruncatingTail)))
        panelLeftTopElement.add(element: leftTopLabelElement)

        let rightTopLabelRect = BDUI.Layout.Rect(x: .relative(.superview(.centerX())),
                                                 y: .relative(.superview(.bottom())),
                                                 width: .relative(.superview(.width(.multiply(0.5)))))
        let rightTopLabelFrame = BDUI.Layout.Frame.dynamicHeight(rect: rightTopLabelRect, padding: .simple(value: .absolute(16)))
        let rightTopLabelLayout = BDUI.Layout(frame: rightTopLabelFrame)
        let rightTopLabelElement = BDUI.Element(elementId: "RightTopLabel",
                                                elementType: _typeName(BDUI.Label.self, qualified: false),
                                                layout: rightTopLabelLayout,
                                                properties: .label(BDUI.Element.Properties.Label(text: text, numberOfLines: 4, backgroundColor: "#9933AA77", color: "#000000", lineBreakMode: .byTruncatingTail)))
        panelRightTopElement.add(element: rightTopLabelElement)

        let leftBottomLabelRect = BDUI.Layout.Rect(x: .relative(.superview(.left())),
                                                   y: .relative(.superview(.bottom())),
                                                   width: .relative(.superview(.width(.multiply(0.5)))))
        let leftBottomLabelFrame = BDUI.Layout.Frame.dynamicHeight(rect: leftBottomLabelRect, padding: .simple(value: .absolute(16)))
        let leftBottomLabelLayout = BDUI.Layout(frame: leftBottomLabelFrame)
        let leftBottomLabelElement = BDUI.Element(elementId: "LeftBottomLabel",
                                                  elementType: _typeName(BDUI.Label.self, qualified: false),
                                                  layout: leftBottomLabelLayout,
                                                  properties: .label(BDUI.Element.Properties.Label(text: text, numberOfLines: 0, backgroundColor: "#9933AA77", color: "#000000", lineBreakMode: .byTruncatingTail)))
        panelLeftBottomElement.add(element: leftBottomLabelElement)

        let rightBottomLabelRect = BDUI.Layout.Rect(x: .relative(.superview(.centerX())),
                                                    y: .relative(.superview(.top())),
                                                    width: .relative(.superview(.width(.multiply(0.5)))))
        let rightBottomLabelFrame = BDUI.Layout.Frame.dynamicHeight(rect: rightBottomLabelRect, padding: .simple(value: .absolute(16)))
        let rightBottomLabelLayout = BDUI.Layout(frame: rightBottomLabelFrame)
        let rightBottomLabelElement = BDUI.Element(elementId: "RightBottomLabel",
                                                   elementType: _typeName(BDUI.Label.self, qualified: false),
                                                   layout: rightBottomLabelLayout,
                                                   properties: .label(BDUI.Element.Properties.Label(text: text, numberOfLines: 0, backgroundColor: "#9933AA77", color: "#000000", lineBreakMode: .byTruncatingTail)))
        panelRightBottomElement.add(element: rightBottomLabelElement)

        let rightBottomLabelRect1 = BDUI.Layout.Rect(x: .relative(.superview(.left())),
                                                     y: .relative(.element(elementId: "RightBottomLabel", type: .bottom())),
                                                     width: .relative(.superview(.width(.multiply(0.5)))))
        let rightBottomLabelFrame1 = BDUI.Layout.Frame.dynamicHeight(rect: rightBottomLabelRect1, padding: .simple(value: .absolute(16)))
        let rightBottomLabelLayout1 = BDUI.Layout(frame: rightBottomLabelFrame1)
        let rightBottomLabelElement1 = BDUI.Element(elementId: "RightBottomLabel1",
                                                    elementType: _typeName(BDUI.Label.self, qualified: false),
                                                    layout: rightBottomLabelLayout1,
                                                    properties: .label(BDUI.Element.Properties.Label(text: text, numberOfLines: 0, backgroundColor: "#9933AA77", color: "#000000", lineBreakMode: .byTruncatingTail)))
        panelRightBottomElement.add(element: rightBottomLabelElement1)

        return rootElement
    }
    
    func encodeElement() {
        guard let layouter else { return }
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(layouter.element) {
            print(String(data: data, encoding: .utf8) ?? "error")
        }
    }
}
