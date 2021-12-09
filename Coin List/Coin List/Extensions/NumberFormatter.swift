//
//  NumberFormatter.swift
//  Coin List
//
//  Created by Murat Yilmaz on 9.12.2021.
//

import Foundation

extension NumberFormatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        return formatter
    }()
}
