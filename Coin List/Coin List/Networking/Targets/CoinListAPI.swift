//
//  CoinListAPI.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Moya
import Foundation

extension TargetType {
    var headers: [String : String]? { nil }
    var sampleData: Data { Data() }
}

enum CoinListAPI {
    case coins
}

extension CoinListAPI: TargetType {
    
    var baseURL: URL { NetworkEnvironment.baseURL.appendingPathComponent("dummy") }
    
    var path: String {
        switch self {
        case .coins: return "coins"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task {
        switch self {
        case .coins: return .requestPlain
        }
    }
}
