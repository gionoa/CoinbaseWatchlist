//
//  CoinDetailViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/13/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class CoinDetailViewController: UIViewController {
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coinbaseBlue
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white

        view.addSubview(priceLabel)

        let margins = view.layoutMarginsGuide
        view.addConstraints([
            priceLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16),
            priceLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            ])
    }
    
    init(_ coin: Coin) {
        super.init(nibName: nil, bundle: nil)
        
        priceLabel.text = formatFloat(coin.price)
        title = coin.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func formatFloat(_ priceText: String) -> String {
        let price: Float = (priceText as NSString).floatValue
        return String(format: "%.2f", price)
    }
}
