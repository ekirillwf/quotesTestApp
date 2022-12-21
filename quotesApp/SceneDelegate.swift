//
//  SceneDelegate.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 20.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        var window: UIWindow?
        
        let viewController = ViewController()
        
        let rootVC = UINavigationController(rootViewController: viewController)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = rootVC
        window?.overrideUserInterfaceStyle = .light
    }
}

