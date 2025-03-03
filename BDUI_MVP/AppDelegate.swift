//
//  AppDelegate.swift
//  BDUI_MVP
//
//  Created by Rybochkin Dmitry on 26.02.2025.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    private(set) static var factory: BDUI.ViewFactoryProtocol = BDUI.ViewFactory().registerAll()
    
    // MARK: - Functions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        return true
    }
    
}

extension BDUI.ViewLayoutProtocol {
    
    // MARK: - Abstract properties
    
    var factory: BDUI.ViewFactoryProtocol { AppDelegate.factory }
}

extension UIViewController {
    
    // MARK: - Abstract properties
    
    var factory: BDUI.ViewFactoryProtocol { AppDelegate.factory }
}

private extension BDUI.ViewFactoryProtocol {
    
    // MARK: - Properties
    
    func registerAll() -> BDUI.ViewFactoryProtocol {
        register { BDUI.ContainerView(layouter: $0) }
        register { BDUI.ImageView(layouter: $0) }
        register { BDUI.Label(layouter: $0) }
        return self
    }
}
