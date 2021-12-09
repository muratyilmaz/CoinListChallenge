//
//  CoinListTVCViewModel.swift
//  Coin List
//
//  Created by Murat Yilmaz on 9.12.2021.
//

final class CoinListTVCViewModel {
    
    private let coin: Coin
    
    var name: String { coin.name }
    var symbol: String { coin.symbol }
    var price: String { coin.price.priceFormatted }
    var change: String { coin.change.percentageFormatted }
    var changeValueIsGreaterThanZero: Bool { coin.change > 0 }
    
    init(coin: Coin) {
        self.coin = coin
    }
}

extension CoinListTVCViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(coin.uuid)
    }
    
    static func == (lhs: CoinListTVCViewModel, rhs: CoinListTVCViewModel) -> Bool {
        lhs.coin.uuid == rhs.coin.uuid
    }
}
