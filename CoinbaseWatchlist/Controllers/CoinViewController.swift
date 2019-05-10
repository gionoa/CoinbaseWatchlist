//
//  MainViewController.swift
//  CoinbaseWatchlist
//
//  Created by gnoa001 on 4/11/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseID)
        return tableView
    }()

    private let modelController = CoinModelController()
    
    private var currencyButton: UIBarButtonItem!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSelectedCurrency()
        setupNavBar()
        
        modelController.fetchData() { error in
            if let error = error {
                let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(errorAlert, animated: true)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
    }

    // MARK: - Setup
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Coinbase Markets"
        
        currencyButton = UIBarButtonItem(title: modelController.selectedCurrency, style: .plain, target: self, action: #selector(currencyButtonTapped(_:)))
        navigationItem.rightBarButtonItem = currencyButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - UserDefaults
    private func loadSelectedCurrency() {
        modelController.selectedCurrency = UserDefaults.selectedCurrency
    }
    
    // MARK: - Actions
    @objc private func currencyButtonTapped(_ sender: UIBarButtonItem) {
        let currencyViewController = CurrencyViewController(selectedCurrencyTickerSymbol: modelController.selectedCurrency)
        let currencyNavigationController = UINavigationController(rootViewController: currencyViewController)
        
        currencyViewController.delegate = self
        
        present(currencyNavigationController, animated: true)
    }
}

extension CoinViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: - TableView Delegate / DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseID, for: indexPath) as! CoinTableViewCell
        
        let coin = modelController.coin(at: indexPath.row)
        cell.configure(coin, currency: modelController.selectedCurrency)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = modelController.coin(at: indexPath.row)
        let detailVC = CoinDetailViewController(coin)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CoinViewController: CurrencyDelegate {
    
    // MARK - Currency Delegate
    func didSelectCurrency(currency: String) {
        modelController.currencyDidChange(currency)
        currencyButton.title = currency
        
        UserDefaults.set(currency: modelController.selectedCurrency)

        modelController.fetchData { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
