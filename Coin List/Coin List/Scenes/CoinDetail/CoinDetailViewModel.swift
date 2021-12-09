//
//  CoinDetailViewModel.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Foundation

protocol CoinDetailViewModelInput {
    func viewDidLoad()
}

protocol CoinDetailViewModelOutput {
    var reloadData: (() -> Void) { get set }
    var cellViewModels: [CoinDetailTVCViewModel] { get set }
    var name: String { get }
    var symbol: String { get }
    var sparkLines: [Double] { get }
}

typealias CoinDetailViewModelType = CoinDetailViewModelInput & CoinDetailViewModelOutput

final class CoinDetailViewModel: CoinDetailViewModelType {
    
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    // MARK: INPUTS
    func viewDidLoad() {
        prepareDetail()
    }
    
    // MARK: OUTPUTS
    var reloadData: (() -> Void) = {}
    var cellViewModels: [CoinDetailTVCViewModel] = []
    var name: String { coin.name }
    var symbol: String { coin.symbol }
    var sparkLines: [Double] { coin.sparkline.map { $0.doubleValue } }
    
    // MARK: PRIVATE
    private func prepareDetail() {
        let priceItem = CoinDetailTVCViewModel(title: "Current Price", value: coin.price.priceFormatted)
        let changeItem = CoinDetailTVCViewModel(title: "Change",
                                                value: coin.change.percentageFormatted,
                                                colorNameForValue: coin.change > 0 ? "highTextColor" : "lowTextColor")
        let marketCapItem = CoinDetailTVCViewModel(title: "Market Cap", value: coin.marketCap.priceFormatted)
        let dailyVolumeItem = CoinDetailTVCViewModel(title: "24H Volume", value: coin.dailyVolume.priceFormatted,
                                                     colorNameForValue: coin.lowVolume ? "lowTextColor" : "highTextColor")
        let urlItem = CoinDetailTVCViewModel(title: "Ranking URL", value: coin.coinrankingUrl)
        cellViewModels.append(contentsOf: [priceItem, changeItem, marketCapItem, dailyVolumeItem, urlItem])
        reloadData()
    }
    
}
