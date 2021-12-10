//
//  NetworkClient.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Foundation
import Moya

struct NetworkEnvironment {
    public static var baseURL: URL { URL(string: "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/")! }
}

struct NetworkClient {
    
    private static let provider = MoyaProvider<MultiTarget>()
    
    @discardableResult
    public static func request(target: TargetType,
                               completion: @escaping (Result<Response, MoyaError>) -> Void,
                               progress: ProgressBlock? = nil) -> Moya.Cancellable  {
        
        return provider.request(MultiTarget(target), callbackQueue: nil, progress: progress) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
