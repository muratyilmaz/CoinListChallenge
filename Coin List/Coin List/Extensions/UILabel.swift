//
//  UILabel.swift
//  Coin List
//
//  Created by Murat Yilmaz on 10.12.2021.
//

import UIKit

extension UILabel {
    static func makeLabel(_ text: String? = nil,
                          textColor: UIColor = UIColor.Theme.darkTextColor,
                          aligment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = aligment
        label.text = text
        return label
    }
}
