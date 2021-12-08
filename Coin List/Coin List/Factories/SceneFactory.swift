//
//  ViewControllerFactory.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import UIKit

final class SceneFactory {
    
    @discardableResult
    static func makeCoinListScene() -> CoinListViewController {
        let coinListViewController = CoinListViewController()
        return coinListViewController
    }
    
    @discardableResult
    static func makeCoinDetailScene() -> CoinDetailViewController {
        let coinDetailViewController = CoinDetailViewController()
        return coinDetailViewController
    }
    
}
