//
//  CurrencyViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/16/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

// MARK: - Currency Delegate Protocol
protocol CurrencyDelegate: class {
    func didSelectCurrency(currency: String)
}

class CurrencyViewController: UIViewController {
    
    // MARK: - Delegate
    weak var delegate: CurrencyDelegate?
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let modelController = CurrencyModelController()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupSearchController()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = NSLocalizedString("Currencies", comment: "")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelButtonTapped(_:)))
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        modelController.fetchCurrencies { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currencies"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    // MARK: - Actions
    @objc private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableViewDelegate / TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return modelController.filteredDataSource.count
        }
        return modelController.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as! CurrencyTableViewCell
        
        let currency: Currency
        if isFiltering {
            currency = modelController.filteredDataSource[indexPath.row]
        } else {
            currency = modelController.dataSource[indexPath.row]
        }
        
        cell.configure(currency)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currency: String
        if isFiltering {
            currency = modelController.filteredDataSource[indexPath.row].tickerSymbol
        } else {
            currency = modelController.dataSource[indexPath.row].tickerSymbol
        }
        
        delegate?.didSelectCurrency(currency: currency)
        
        dismissAfterCurrencySelection()
    }
    
    // MARK: - Helpers
    
    // will find a better solution
    fileprivate func dismissAfterCurrencySelection() {
        if searchController.isActive {
            dismiss(animated: false) {
                self.dismiss(animated: true)
            }
        } else {
            dismiss(animated: true)
        }
    }
}

extension CurrencyViewController: UISearchResultsUpdating {
    // MARK: - SearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(),
              searchText.isEmpty == false else { return }
        
        let filteredData =  modelController.dataSource.filter { $0.tickerSymbol.lowercased().contains(searchText) }
        modelController.filteredDataSource = filteredData
        
        tableView.reloadData()
    }
}
