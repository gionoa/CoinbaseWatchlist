//
//  CoinTableViewCell.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/12/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseID = String(describing: CoinTableViewCell.self)
    
    private lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var coinTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
       // label.setContentHuggingPriority(.defaultLow, for: .vertical)
    //    label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var tickerSymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0 // change back to 0 if needed
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
     //   label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Setup
    private func setupCell() {
        contentView.addSubview(coinImageView)
        contentView.addSubview(coinTitleLabel)
        contentView.addSubview(tickerSymbolLabel)
        contentView.addSubview(priceLabel)
        
        accessoryType = .disclosureIndicator
        let inset: CGFloat = 8.0
        let margins = contentView.layoutMarginsGuide
        // make the imageView height == to stackView height
        // coinimageview, cointitlelabel, tickersymbollabel, pricelabel
        contentView.addConstraints([
            coinImageView.heightAnchor.constraint(equalToConstant: 64),//: coinTitleLabel.heightAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: 64), //coinImageView.heightAnchor),
            coinImageView.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor),
            coinImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            coinImageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            coinImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
        
            coinTitleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: inset),
        //    coinTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinTitleLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: inset),
            coinTitleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -inset),
         //   coinTitleLabel.bottomAnchor.constraint(equalTo: tickerSymbolLabel.topAnchor),
            
            tickerSymbolLabel.topAnchor.constraint(equalTo: coinTitleLabel.bottomAnchor, constant: inset),
            tickerSymbolLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: inset),
            tickerSymbolLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -inset),
            tickerSymbolLabel.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor, constant: inset),
            
            priceLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: inset),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: coinTitleLabel.trailingAnchor, constant: inset),
            priceLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
            ])
    }
    
    // MARK: - Helpers
    func configure(_ coin: Coin, currency: String) {
        coinImageView.image = UIImage(named: coin.tickerSymbol)
        coinTitleLabel.text = coin.title
        tickerSymbolLabel.text = coin.tickerSymbol
        
        let price = formatFloat(coin.price)
        if currency == "USD" {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = "\(price) \(currency)"
        }
        layoutIfNeeded()
    }
    
    func formatFloat(_ priceText: String) -> String {
        let price: Float = (priceText as NSString).floatValue
        return String(format: "%.2f", price)
    }
}
