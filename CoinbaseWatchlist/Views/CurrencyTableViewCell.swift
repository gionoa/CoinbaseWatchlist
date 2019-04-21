//
//  CurrencyTableViewCell.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/20/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation
import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: - Reuse Identifier
    static let reuseIdentifier = String(describing: CurrencyTableViewCell.self)
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    private lazy var tickerSymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(currencyLabel)
        contentView.addSubview(tickerSymbolLabel)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupCell() {
        let inset: CGFloat = 8
        let margins = contentView.layoutMarginsGuide
        contentView.addConstraints([
            currencyLabel.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            tickerSymbolLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: (inset / 4)),
            tickerSymbolLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tickerSymbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor),
            tickerSymbolLabel.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor)
            ])
    }
    
    // MARK: - Helpers
    func configure(_ currency: Currency) {
        currencyLabel.text = currency.name
        tickerSymbolLabel.text = currency.symbol
    }
}
