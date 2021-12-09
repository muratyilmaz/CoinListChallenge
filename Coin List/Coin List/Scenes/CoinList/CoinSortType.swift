//
//  CoinSortType.swift
//  Coin List
//
//  Created by Murat Yilmaz on 9.12.2021.
//

import Foundation

enum CoinSortType: String, CaseIterable {
    
    case rank = "rank"
    case dailyVolume = "24hVolume"
    case listedAt = "listedAt"
    case price = "price"
    case marketCap = "marketCap"
    case change = "change"
    
    var localizedTitle: String {
        switch self {
        case .rank: return "Rank"
        case .dailyVolume: return "24H Volume"
        case .listedAt: return "Listed At"
        case .price: return "Price"
        case .marketCap: return "Market Cap"
        case .change: return "Change"
        }
    }
    
    func sort(_ coins: inout [Coin] ) {
        switch self {
        case .price:
            coins.sort { $0.price > $1.price }
        case .rank:
            coins.sort { $0.rank < $1.rank }
        case .change:
            coins.sort { $0.change > $1.change }
        case .dailyVolume:
            coins.sort { $0.dailyVolume > $1.dailyVolume }
        case .marketCap:
            coins.sort { $0.marketCap > $1.marketCap }
        case .listedAt:
            coins.sort { $0.listedAt > $1.listedAt }
        }
    }
}
