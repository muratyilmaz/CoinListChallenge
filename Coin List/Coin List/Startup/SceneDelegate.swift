//
//  SceneDelegate.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        self.window?.rootViewController = SceneFactory.makeCoinListScene(CoinListViewModel(service: CoinListService()))
        self.window?.makeKeyAndVisible()
    }
}

