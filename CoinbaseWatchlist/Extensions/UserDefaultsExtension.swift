//
//  UserDefaultsExtension.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 5/6/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

enum Keys: String {
    case selectedCurrency
    case currencyList
}

extension UserDefaults {
    func set(currency: String, forKey key: String) {
        self.set(currency, forKey: key)
    }

    func set(currencyList: [Currency], forKey key: String) {
        self.set(currencyList, forKey: key)
    }
    
    func selectedCurrency(forKey key: String) -> String {
        guard let selectedCurrency = self.string(forKey: key) else { return "USD" }
        return selectedCurrency
    }
}
