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

protocol ModelControllerDelegate {
    func workCompleted()
}


class ModelController {

    // MARK: Properties
    fileprivate var coins = [Coin]()
    
    let tickerSymbols = ["BTC", "ETH", "BCH", "LTC", "ETC", "USDC", "ZEC", "ZRX", "BAT"]
    
    var delegate: ModelControllerDelegate?
    
    var dataSource: [Coin] {
        return coins
    }
    
    var count: Int {
        return dataSource.count
    }
    
    var currency: String {
        return "USD"
    }
    
    func fetchData(_ completion: @escaping (Error?) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchCoins(currency: currency) { (result) in
            switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    completion(error)
            }
        }
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.workCompleted()
        }
    }
    
    fileprivate func fetchCoins(currency: String, completion: @escaping (Result<[Coin], NetworkError>) -> Void) {
        var currentCoins = [Coin]()
        coins.reserveCapacity(tickerSymbols.count)
        
        var errorMessage = ""
        for tickerSymbol in tickerSymbols {
            fetchCoin(tickerSymbol: tickerSymbol, currency: currency) { result in
                switch result {
                case .success(let coin):
                    currentCoins.append(coin)
                    print(coin)
                    print("Adding")
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
            if currentCoins.count > 0 {
                completion(.success(currentCoins))
            }
            completion(.failure(.fetchingError(errorMessage)))
        }
    }
    
    
    fileprivate func fetchCoin(tickerSymbol: String, currency: String, completion: @escaping (Result<Coin, NetworkError>) -> Void) {
        CoinbaseAPI.fetchData(tickerSymbol: tickerSymbol, currency: currency) { result in
            switch result {
            case .success(let coin):
                completion(.success(coin))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
