//
//  CoinListTableViewCell.swift
//  Coin List
//
//  Created by Murat Yilmaz on 7.12.2021.
//

import UIKit
import Reusable

private extension UILabel {
    static func makeLabel(_ text: String? = nil,
                          textColor: UIColor = UIColor.Theme.darkTextColor,
                          aligment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.textAlignment = aligment
        label.text = text
        return label
    }
}

final class CoinListTableViewCell: UITableViewCell, Reusable {
    
    private lazy var symbolLabel = UILabel.makeLabel(textColor: .Theme.lightTextColor)
    private lazy var nameLabel = UILabel.makeLabel(textColor: .Theme.darkTextColor)
    private lazy var priceLabel = UILabel.makeLabel(textColor: .Theme.darkTextColor, aligment: .right)
    private lazy var priceChangeLabel = UILabel.makeLabel(textColor: .Theme.highTextColor, aligment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        selectionStyle = .none
        
        backgroundColor = .clear
        let containerView = setupContainerView()
        
        let contentStackView = UIStackView()
        contentStackView.spacing = 10
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .fillEqually
        containerView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing
                .equalToSuperview()
                .inset(10)
        }
        
        let leftStackView = UIStackView(arrangedSubviews: [symbolLabel, nameLabel])
        leftStackView.axis = .vertical
        leftStackView.alignment = .leading
        leftStackView.spacing = 4
        contentStackView.addArrangedSubview(leftStackView)
        
        let rightStackView = UIStackView(arrangedSubviews: [priceLabel, priceChangeLabel])
        rightStackView.axis = .vertical
        rightStackView.alignment = .trailing
        rightStackView.spacing = 4
        contentStackView.addArrangedSubview(rightStackView)
    }
    
    private func setupContainerView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing
                .equalToSuperview()
                .inset(8)
        }
        return containerView
    }
    
    func configure(_ viewModel: CoinListTVCViewModel) {
        self.nameLabel.text = viewModel.name
        self.symbolLabel.text = viewModel.symbol
        self.priceLabel.text = viewModel.price
        self.priceChangeLabel.textColor = viewModel.changeValueIsGreaterThanZero ?  UIColor.Theme.highTextColor : UIColor.Theme.lowTextColor
        self.priceChangeLabel.text = viewModel.change
    }
}
