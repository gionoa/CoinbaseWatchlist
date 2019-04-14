//
//  CoinDetailViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/13/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class CoinDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    init(_ coin: Coin) {
        super.init(nibName: nil, bundle: nil)
        
        title = coin.title
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
