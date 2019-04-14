//
//  CoinbaseAPI.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/11/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

// MARK: - Network Error
enum NetworkError: Error {
    case fetchingError(String)
    case decodingError(String)
}

struct CoinbaseAPI {
    
    // MARK: - Properties
    static let coinTitles = ["BAT": "Basic Attention Token", "BTC": "Bitcoin", "ETH": "Ethereum",
                             "XRP": "XRP (Ripple)", "BCH": "Bitcoin Cash", "LTC": "Litecoin",
                             "XLM": "Stellar Lumens", "ETC": "Ethereum Classic", "ZEC": "Zcash",
                             "USDC": "USD Coin", "ZRX": "0x"]

    // MARK: - Network
    static func fetchData(tickerSymbol: String, currency: String, completion: @escaping ((Result<Coin, NetworkError>) -> Void)) {
        let url = makeURL(tickerSymbol: tickerSymbol, currency: currency)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                let result = NetworkError.fetchingError(error!.localizedDescription)
                completion(.failure(result))
                return
            }
            
            do {
                struct Data: Decodable {
                    let data: DecodedCoin
                }
                
                struct DecodedCoin: Decodable {
                    let amount: String
                    let currency: String
                }
                
                let decodedData = try JSONDecoder().decode(Data.self, from: data)
                let coin = Coin(title: coinTitles[tickerSymbol],
                                tickerSymbol: tickerSymbol,
                                price: decodedData.data.amount,
                                currency: decodedData.data.currency)
                
                completion(.success(coin))
                
            } catch let decodingError {
                let result = NetworkError.decodingError(decodingError.localizedDescription)
                completion(.failure(result))
            }
        }.resume()
    }
    
    // MARK: - Helpers
    fileprivate static func makeURL(tickerSymbol: String, currency: String) -> URL {
        return URL(string: "https://api.coinbase.com/v2/prices/\(tickerSymbol)-\(currency)/spot")!
    }
}
