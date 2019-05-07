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
    fileprivate let archiveURL = getDocumentsDirectory().appendingPathComponent("CurrencyList")
    
    // MARK: - Properties
    private (set) var dataSource = [Currency]()
    
    var filteredDataSource = [Currency]()
    
    // MARK: - Network
    func fetchCurrencies(completion: @escaping (Error?) -> Void) {

        do {
            let data = try Data(contentsOf: archiveURL)
            if let currencyList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Currency] {
                dataSource = currencyList
                completion(nil)
                return
            }
        } catch let unarchivingError {
            print(unarchivingError.localizedDescription)
        }
        
        CoinbaseAPI.fetchCurrencies { (result) in
            switch result {
                case .success(let currencies):
                    self.dataSource = currencies
                    
                    do {
                        try self.write(currencies, to: self.archiveURL)
                    } catch let archivingError {
                        print(archivingError)
                    }
                    completion(nil)
                
                case .failure(let error):
                completion(error)
            }
        }
    }
    
    // MARK: - NSKeyedArchiver - Write
    fileprivate func write(_ currencyList: [Currency], to url: URL) throws {
        let data = try NSKeyedArchiver.archivedData(withRootObject: currencyList, requiringSecureCoding: false)
        try data.write(to: url)
    }
    
    // MARK: - Helpers
    fileprivate static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
