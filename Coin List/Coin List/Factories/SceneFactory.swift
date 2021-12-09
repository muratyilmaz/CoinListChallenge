//
//  ViewControllerFactory.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import UIKit

final class SceneFactory {
    
    @discardableResult
    static func makeCoinListScene(_ viewModel: CoinListViewModelType) -> UINavigationController {
        let coinListViewController = CoinListViewController()
        coinListViewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: coinListViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = UIColor.Theme.darkTextColor
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme.darkTextColor]
        navigationController.navigationBar.largeTitleTextAttributes = titleTextAttributes
        navigationController.navigationBar.titleTextAttributes = titleTextAttributes
        
        return navigationController
    }
    
    @discardableResult
    static func makeCoinDetailScene(_ viewModel: CoinDetailViewModelType) -> CoinDetailViewController {
        let coinDetailViewController = CoinDetailViewController()
        coinDetailViewController.viewModel = viewModel
        return coinDetailViewController
    }
    
}
