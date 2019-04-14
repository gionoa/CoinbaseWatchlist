//
//  CoinTableViewCell.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/12/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: CoinTableViewCell.self)
    
    private lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var coinTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var coinTickerLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var usdStackView: UIStackView = { // dollar, currency; horizontal
        let stackView = UIStackView(arrangedSubviews: [priceLabel, currencyLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var stackView: UIStackView = { // main horizontal stackview
        let stackView = UIStackView(arrangedSubviews: [coinTitleLabel, usdStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // remove image from stackview
    
    private func setupCell() {
        contentView.addSubview(coinImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(coinTickerLabel)
        
        accessoryType = .disclosureIndicator
        
        let inset: CGFloat = 8.0
        let margins = contentView.layoutMarginsGuide
        
        let stackTopAnchor = stackView.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor)
        let stackBottomAnchor = stackView.bottomAnchor.constraint(greaterThanOrEqualTo: margins.bottomAnchor)
        stackTopAnchor.priority = .defaultHigh
        stackBottomAnchor.priority = .defaultLow
        contentView.addConstraints([
            coinImageView.heightAnchor.constraint(equalToConstant: 64),//contentView.heightAnchor, constant: -(inset * 4)),
            coinImageView.widthAnchor.constraint(equalToConstant: 64),
            coinImageView.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor),
            coinImageView.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor),
            coinImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            coinImageView.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -(inset * 2)),
        
            stackTopAnchor, stackBottomAnchor,
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: coinTickerLabel.leadingAnchor, constant: -inset),
            
            coinTickerLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: inset),
            coinTickerLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
            ])
    }
    
    func configure(_ coin: Coin) {
        
        coinImageView.image = UIImage(named: coin.tickerSymbol)
        coinTitleLabel.text = coin.title
        coinTickerLabel.text = coin.tickerSymbol
        currencyLabel.text = coin.currency
        priceLabel.text = "$\(coin.price)"
    }
}

