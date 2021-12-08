//
//  CoinListViewController.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import UIKit

final class CoinListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinListService().coins { result in
            switch result {
            case .success(let response):
                print(response.stats)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
