//
//  Currency.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/17/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

class Currency: NSObject, NSCoding {
    
    // MARK: - Keys
    fileprivate struct Keys {
        static let tickerSymbol = "tickerSymbol"
        static let title = "title"
    }
  
    // MARK: - Properties
    let tickerSymbol: String
    let title: String
    
    // MARK: - Lifecycle
    init(tickerSymbol: String, title: String) {
        self.tickerSymbol = tickerSymbol
        self.title = title
    }
    
    // MARK: - NSCoding init - encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tickerSymbol, forKey: Keys.tickerSymbol)
        aCoder.encode(title, forKey: Keys.title)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let tickerSymbol = aDecoder.decodeObject(forKey: Keys.tickerSymbol) as? String,
            let title = aDecoder.decodeObject(forKey: Keys.title) as? String else {
                return nil
        }
        
        self.init(tickerSymbol: tickerSymbol, title: title)
    }
}
