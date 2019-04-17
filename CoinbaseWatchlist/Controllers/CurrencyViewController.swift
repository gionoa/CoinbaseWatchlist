//
//  CurrencyViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/16/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
        view.backgroundColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    }
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}
