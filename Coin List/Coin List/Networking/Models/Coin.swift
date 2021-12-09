//
//  CLCurrency.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

struct Coin: Decodable {
    
    let uuid: String
    let symbol: String
    let name: String
    let color: String?
    let iconUrl: String
    let marketCap: Double
    let price: Double
    let listedAt: Int
    let tier: Int
    let change: Double
    let rank: Int
    let sparkline: [String]
    let lowVolume: Bool
    let coinrankingUrl: String
    let dailyVolume: Double
    let btcPrice: Double
    
    private enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, iconUrl, marketCap, price, listedAt,
             tier, change, rank, sparkline, lowVolume, coinrankingUrl, dailyVolume = "24hVolume", btcPrice
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(String.self, forKey: .uuid)
        symbol = try container.decode(String.self, forKey: .symbol)
        name = try container.decode(String.self, forKey: .name)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        iconUrl = try container.decode(String.self, forKey: .iconUrl)
        
        let marketCap = try container.decode(String.self, forKey: .marketCap)
        self.marketCap = marketCap.doubleValue
        
        let price = try container.decode(String.self, forKey: .price)
        self.price = price.doubleValue
        
        listedAt = try container.decode(Int.self, forKey: .listedAt)
        tier = try container.decode(Int.self, forKey: .tier)
        
        let change = try container.decode(String.self, forKey: .change)
        self.change = change.doubleValue
        
        rank = try container.decode(Int.self, forKey: .rank)
        sparkline = try container.decode([String].self, forKey: .sparkline)
        lowVolume = try container.decode(Bool.self, forKey: .lowVolume)
        coinrankingUrl = try container.decode(String.self, forKey: .coinrankingUrl)
        
        let dailyVolume = try container.decode(String.self, forKey: .dailyVolume)
        self.dailyVolume = dailyVolume.doubleValue
        
        let btcPrice = try container.decode(String.self, forKey: .btcPrice)
        self.btcPrice = btcPrice.doubleValue
    }
}
