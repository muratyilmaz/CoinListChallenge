//
//  CLCoinsResponse.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Foundation

struct CoinListResponse: Decodable {
    
    struct Stats: Decodable {
        let total: Int
        let totalCoins: Int
        let totalMarkets: Int
        let totalExchanges: Int
        let totalMarketCap: String
        let total24hVolume: String
    }
    
    let stats: Stats
    let coins: [Currency]
}
