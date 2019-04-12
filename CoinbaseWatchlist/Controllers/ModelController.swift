//
//  ModelController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/11/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

//protocol ModelControllerInput {
//}
//
//protocol ModelControllerOutput {
//    var dataSource: [Coin] { get set }
//    var count: Int { get }
//}
//protocol ModelControllerType: ModelControllerInput, ModelControllerOutput {
//    var input: ModelControllerInput { get }
//    var output: ModelControllerOutput { get }
//}

class ModelController {

    // MARK: Properties
    fileprivate var coins = [Coin]()
    
    let tickerSymbols = ["BTC", "ETH", "BCH", "LTC", "ETC", "USDC", "ZEC", "ZRX", "BAT"]
    
    var dataSource: [Coin] {
        return coins
    }
    
    var count: Int {
        return dataSource.count
    }

    func fetchData(currency: String, completion: @escaping (Error?) -> Void) {
        
    }
    
}
