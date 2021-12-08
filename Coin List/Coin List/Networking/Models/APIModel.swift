//
//  CLAPIModel.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import Foundation

struct APIModel<T: Decodable>: Decodable {
    let data: T?
    let status: String
}
