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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var coinTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var coinTickerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
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
    
    private lazy var titleStackView: UIStackView = { // title, and usd stack view; vertical
        let stackView = UIStackView(arrangedSubviews: [coinTitleLabel, usdStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var stackView: UIStackView = { // main horizontal stackview
        let stackView = UIStackView(arrangedSubviews: [coinImageView, titleStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.addSubview(stackView)
        view.addSubview(coinTickerLabel)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(shadowView)
        
        let inset: CGFloat = 8.0
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addConstraints([
            shadowView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: inset),
            shadowView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            shadowView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            shadowView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -inset)
            ])
    }
    
    func configure(_ coin: Coin) {
        
    }
}

