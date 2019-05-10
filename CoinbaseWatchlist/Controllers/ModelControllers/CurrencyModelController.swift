//
//  CurrenciesModelController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/17/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import Foundation

class CurrencyModelController {
    
    // MARK: - Currency List URL
    fileprivate let archiveURL = getDocumentsDirectory()
    
    // MARK: - Properties
    private (set) var dataSource = [Currency]()
    
    var filteredDataSource = [Currency]()
    
    // MARK: - Network
    func fetchCurrencies(completion: @escaping (Error?) -> Void) {
        if tryLoadingData(url: archiveURL) == nil {
            completion(nil)
            return
        }
        
        CoinbaseAPI.fetchCurrencies { (result) in
            switch result {
                case .success(let currencies):
                    self.dataSource = currencies
                    
                    if let errorOrNil = self.tryWritingData(currencyList: currencies, url: self.archiveURL) {
                        completion(errorOrNil)
                    }
                    completion(nil)
                
                case .failure(let error):
                    completion(error)
            }
        }
    }
    
    // MARK: - NSKeyedArchiver - Write
    fileprivate func tryWritingData(currencyList: [Currency], url: URL) -> Error? {
        do {
            try self.write(currencyList, to: url)
            
        } catch let archivingError {
            return archivingError
        }
        return nil
    }
    
    fileprivate func write(_ currencyList: [Currency], to url: URL) throws {
        let data = try NSKeyedArchiver.archivedData(withRootObject: currencyList, requiringSecureCoding: false)
        try data.write(to: url)
    }
    
    // MARK: - Helpers
    fileprivate static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("CurrencyList")
        return paths
    }
    
    fileprivate func tryLoadingData(url: URL) -> Error? {
        var error: Error?
        do {
            let data = try Data(contentsOf: url)
            
            if let currencyList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Currency] {
                dataSource = currencyList
                error = nil
            }
            
        } catch let unarchivingError {
            error = unarchivingError
        }
        return error
    }
    
    func index(forTickerSymbol tickerSymbol: String) -> Int? {
        let currencyCollection: [Currency]
        
        if filteredDataSource.isEmpty {
            currencyCollection = dataSource
            
        } else {
            currencyCollection = filteredDataSource
        }
        
        let tickerSymbolIndex = currencyCollection.firstIndex { $0.tickerSymbol == tickerSymbol }
        return tickerSymbolIndex
    }
}
