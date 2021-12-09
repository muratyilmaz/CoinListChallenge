//
//  CoinDetailTVCViewModel.swift
//  Coin List
//
//  Created by Murat Yilmaz on 9.12.2021.
//

import Foundation

final class CoinDetailTVCViewModel {
    
    let id = UUID()
    let title: String
    let value: String
    var colorNameForValue: String?
    
    init(title: String, value: String, colorNameForValue: String? = nil) {
        self.title = title
        self.value = value
        self.colorNameForValue = colorNameForValue
    }
}

extension CoinDetailTVCViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CoinDetailTVCViewModel, rhs: CoinDetailTVCViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
