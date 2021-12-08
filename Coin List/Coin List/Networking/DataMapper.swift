//
//  APIDataMapper.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Moya
import Alamofire

enum NetworkError: Error {
    case serviceFailure(String)
    case encodingFailure(Error)
    case moyaError(MoyaError)
}

struct DataMapper {
    static func map<T: Decodable>(_ result: Result<Response, MoyaError>) -> Result<T, NetworkError> {
        switch result {
        case .success(let response):
            do {
                let apiResponse = try response.map( APIModel<T>.self )
                guard let data = apiResponse.data else {
                    return .failure( .serviceFailure("Data cannot be empty...") )
                }
                return .success(data)
            } catch {
                return .failure(.encodingFailure(error))
            }
        case .failure(let error):
            return .failure(.moyaError(error))
        }
    }
}
