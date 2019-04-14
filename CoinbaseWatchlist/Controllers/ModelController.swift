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

    // MARK: - Properties
    
    private (set) var dataSource = [Coin]()
    private let tickerSymbols = ["BTC", "ETH", "BCH", "LTC", "ETC", "USDC", "ZEC", "ZRX", "BAT"]
    private let currency = "USD"
    
    // MARK: - Fetch
    func fetchData(completion: @escaping (Error?) -> Void) {
        var error = NetworkError.decodingError("")
        let dispatchGroup = DispatchGroup()
        
        for tickerSymbol in tickerSymbols {
            
            dispatchGroup.enter()
            fetchCoin(tickerSymbol: tickerSymbol, currency: currency) { [weak self] result in
                switch result {
                case .success(let coin):
                    self?.dataSource.append(coin)
                    
                case .failure(let failureError):
                    error = failureError
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if self.dataSource.count > 0 {
                completion(nil)

            } else {
                completion(error)
            }
        }
    }
    
    private func fetchCoin(tickerSymbol: String, currency: String, completion: @escaping (Result<Coin, NetworkError>) -> Void) {
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
