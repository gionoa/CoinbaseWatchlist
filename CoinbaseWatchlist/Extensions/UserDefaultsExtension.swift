//
//  UserDefaultsExtension.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 5/6/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

extension UserDefaults {

    // MARK: - Keys
    private struct Keys {
        static let selectedCurrency = "selectedCurrency"
    }
    
    // MARK: - Write
    static func set(currency: String) {
        UserDefaults.standard.set(currency, forKey: UserDefaults.Keys.selectedCurrency)
    }
    
    // MARK: - Read
    static var selectedCurrency: String {
        guard let selectedCurrency = UserDefaults.standard.string(forKey: UserDefaults.Keys.selectedCurrency) else {
            return "USD"
        }
        return selectedCurrency
    }
}
