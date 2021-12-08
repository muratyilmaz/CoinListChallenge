//
//  CLCurrency.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

struct Currency: Decodable {
    let uuid: String
    let symbol: String
    let name: String
    let color: String?
    let iconUrl: String
    let marketCap: String
    let price: String
    let listedAt: Int
    let tier: Int
    let change: String
    let rank: Int
    let sparkline: [String]
    let lowVolume: Bool
    let coinrankingUrl: String
//    let 24hVolume: String
    let btcPrice: String
}
