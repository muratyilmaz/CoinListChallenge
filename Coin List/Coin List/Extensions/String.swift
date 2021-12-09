//
//  String.swift
//  Coin List
//
//  Created by Murat Yilmaz on 9.12.2021.
//

import Foundation

extension Double {
    
    var priceFormatted: String {
        let doubleValue = NSNumber(value: self)
        return NumberFormatter.currency.string(from: doubleValue) ?? "N/A"
    }
    
    var percentageFormatted: String {
        var string = String(format: "%.2f%%", self)
        if self > 0 { string = "+" + string }
        return string
    }
}

extension String {
    var doubleValue: Double { (self as NSString).doubleValue }
}
