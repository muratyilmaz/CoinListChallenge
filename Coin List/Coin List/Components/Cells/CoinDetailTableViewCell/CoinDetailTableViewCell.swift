//
//  CoinDetailTableViewCell.swift
//  Coin List
//
//  Created by Murat Yilmaz on 9.12.2021.
//

import Foundation
import Reusable
import UIKit

private extension UILabel {
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

final class CoinDetailTableViewCell: UITableViewCell, Reusable {
    
    private lazy var titleLabel = UILabel.makeLabel(textColor: .Theme.darkTextColor)
    private lazy var detailLabel = UILabel.makeLabel(textColor: .Theme.lightTextColor, aligment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        let contentStackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        contentStackView.spacing = 10
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .fillEqually
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing
                .equalToSuperview()
                .inset(10)
        }
    }
    
    func configure(_ viewModel: CoinDetailTVCViewModel) {
        titleLabel.text = viewModel.title
        detailLabel.text = viewModel.value
        if let colorName = viewModel.colorNameForValue, let color = UIColor(named: colorName) {
            detailLabel.textColor = color
        }
    }
}
