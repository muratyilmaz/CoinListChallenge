//
//  CoinListViewModel.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Foundation

protocol CoinListViewModelInput {
    func viewDidLoad()
    func applySort(_ sortType: CoinSortType)
}

protocol CoinListViewModelOutput {
    var reloadData: (() -> Void) { get set }
    var onError: ((NetworkError) -> Void) { get set }
    var coinViewModels: [CoinListTVCViewModel] { get set }
    var sortType: CoinSortType { get set }
    func coin(at indexPath: IndexPath) -> Coin
}

typealias CoinListViewModelType = CoinListViewModelInput & CoinListViewModelOutput
final class CoinListViewModel: CoinListViewModelInput, CoinListViewModelOutput {
    
    // MARK: INPUT
    func viewDidLoad() {
        service.coins { result in
            switch result {
            case .success(let response):
                self.coins = response.coins
                self.applySort(.rank)
            case .failure(let error):
                self.onError(error)
            }
        }
    }
    
    func applySort(_ sortType: CoinSortType) {
        self.sortType = sortType
        self.sortType.sort(&self.coins)
        self.coinViewModels = self.coins.map { CoinListTVCViewModel(coin: $0) }
        self.reloadData()
    }
    
    // MARK: OUTPUT
    var reloadData: (() -> Void) = {}
    var onError: ((NetworkError) -> Void) = { _ in }
    var sortType: CoinSortType = .rank
    var coinViewModels: [CoinListTVCViewModel] = []
    
    func coin(at indexPath: IndexPath) -> Coin {
        self.coins[indexPath.row]
    }
    
    private let service: CoinListServicing
    private var coins: [Coin] = []
    
    init( service: CoinListServicing ) {
        self.service = service
    }
}
