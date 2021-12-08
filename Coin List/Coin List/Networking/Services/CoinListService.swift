//
//  CoinListService.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Foundation

protocol CoinListServicing {
    func coins(completion: @escaping (Result<CoinListResponse, NetworkError>) -> Void )
}

extension CoinListServicing {
    func coins(completion: @escaping (Result<CoinListResponse, NetworkError>) -> Void ) {
        NetworkClient.request(target: CoinListAPI.coins) { result in
            completion(DataMapper.map(result))
        }
    }
}

struct CoinListService: CoinListServicing {}
